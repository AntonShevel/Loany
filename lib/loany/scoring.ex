defmodule Loany.Scoring do

  alias Loany.MinLoanAmount

  @min_rate 4
  @max_rate 12
  @prime_rate 9.99

  @doc """
  Calculate interest rate based on application amount
  """
  def calculate(amount) do
    comparison = MinLoanAmount.compare_and_update(amount)

    cond do
      # lower amount than any of the previous applications -> reject
      match?({:lower, _}, comparison) -> nil
      # if prime number -> interest rate 9.99%
      prime_number?(amount) -> @prime_rate
      # otherwise -> with random interest rate between 4% and 12%
      true -> random_rate(@min_rate, @max_rate)
    end
  end
  defp prime_number?(number = %Decimal{}) do
    float_number = Decimal.to_float(number)
    float_number == Float.floor(float_number) and float_number |> trunc |> prime_number?
  end
  defp prime_number?(number) when number in [2, 3], do: true
  defp prime_number?(number) do
    # there are different ways to test primality with different complexity
    # I'll start with a simple one
    bound = number
    |> :math.sqrt
    |> trunc

    !Enum.any?(2..bound, fn divisor -> rem(number, divisor) == 0 end)
  end

  defp random_rate(min, max) when max > min do
    # generate random float number between [min;max]
    min_bound = max(min * 100 - 1, 0)
    max_bound = (max - min) * 100 + 1
    # rand.uniform generates integer in range [1;n]
    max_bound |> :rand.uniform() |> Kernel.+(min_bound) |> Kernel./(100)
  end
end
