defmodule LoanyWeb.PageController do
  use LoanyWeb, :controller

  alias Loany.{LoanApplication, Repo, Scoring}

  def index(conn, _params) do
    changeset = LoanApplication.changeset(%LoanApplication{})
    render(conn, "index.html", changeset: changeset)
  end

  def create(conn, %{"loan_application" => loan_application}) do
    %LoanApplication{}
    |> LoanApplication.changeset(loan_application)
    |> Repo.insert
    |> case do
         {:ok, application} ->
           application.amount
           |> Scoring.calculate()
           |> create_loan_resolution!(application)
           |> case do
                %{status: :approved} = resolution -> render(conn, "approval.html", application: application, resolution: resolution)
                _ -> render(conn, "rejection.html")
              end
         {:error, changeset} -> render(conn, "index.html", changeset: changeset)
       end
  end

  defp create_loan_resolution!(rate, application) do
    status = if (rate == nil), do: :rejected, else: :approved

    application
    |> Ecto.build_assoc(:loan_resolution, status: status, rate: rate)
    |> Repo.insert!
  end
end
