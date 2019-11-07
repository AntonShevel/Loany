defmodule Loany.LoanResolution do
  use Ecto.Schema
  import Ecto.Changeset
  import EctoEnum

  defenum(StatusEnum, approved: "approved", rejected: "rejected")

  schema "loan_resolutions" do
    field :rate, :decimal
    field :status, StatusEnum
    belongs_to :loan_application, Loany.LoanApplication

    timestamps()
  end

  @doc false
  def changeset(loan_resolution, attrs) do
    loan_resolution
    |> cast(attrs, [:status, :rate])
    |> validate_required([:status, :rate])
  end
end
