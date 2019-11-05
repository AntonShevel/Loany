defmodule Loany.LoanApplication do
  use Ecto.Schema
  import Ecto.Changeset

  schema "loan_applications" do
    field :first_name, :string
    field :last_name, :string

    timestamps()
  end

  @type t :: %Asset{
               id: Ecto.UUID.type() | nil,
               url: String.t() | nil,
               title: String.t() | nil,
             }

  @doc false
  def changeset(loan_application, attrs) do
    loan_application
    |> cast(attrs, [:first_name, :last_name])
    |> validate_required([:first_name, :last_name])
  end
end
