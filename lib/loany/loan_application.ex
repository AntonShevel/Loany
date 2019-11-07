defmodule Loany.LoanApplication do
  use Loany.Model

  schema "loan_applications" do
    field :first_name, :string
    field :last_name, :string
    field :amount, :decimal
    field :phone, :string
    field :email, :string
    has_one :loan_resolution, Loany.LoanResolution

    timestamps()
  end

  @required_fields [:first_name, :last_name, :amount, :phone, :email]

  @doc false
  def changeset(loan_application, attrs \\ %{}) do
    loan_application
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
    |> validate_length(:phone, max: 20, min: 7)
    |> validate_length(:first_name, max: 255)
    |> validate_length(:last_name, max: 255)
    |> validate_number(:amount, greater_than: 0)
    |> validate_format(:email, ~r/@/)
  end

  def min_amount(query) do
    from application in query, select: min(application.amount)
  end
end
