defmodule Loany.MinLoanAmount do
  use GenServer

  alias Loany.LoanApplication
  alias Loany.Repo

  def start_link(opts \\ []) do
    # get initial state from the DB, decimal or nil
    min_amount = LoanApplication |> LoanApplication.min_amount() |> Repo.one! |> IO.inspect(label: "MIN AMOUNT")
    GenServer.start_link(__MODULE__, [min_amount: min_amount], opts ++ [name: __MODULE__])
  end

  def compare_and_update(amount) do
    GenServer.call(__MODULE__, {:compare_and_update, amount}) |> IO.inspect(label: "GenServer.call")
  end

  @impl true
  def handle_call({:compare_and_update, amount}, _from, state) do
    %{min_amount: min_amount} = state
    cond do
      # update state if database had no records when genserver started
      is_nil(min_amount) -> {:reply, {:higher, min_amount}, Map.put(state, :min_amount, amount)}
      Decimal.gt?(amount, min_amount) -> {:reply, {:higher, min_amount}, state}
      true -> {:reply, {:lower, min_amount}, state}
    end
  end

  @impl true
  def init(args) do
    [min_amount: min_amount] = args

    {:ok, %{min_amount: min_amount}}
  end
end
