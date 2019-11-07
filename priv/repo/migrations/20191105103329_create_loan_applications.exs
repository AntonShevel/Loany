defmodule Loany.Repo.Migrations.CreateLoanApplications do
  use Ecto.Migration

  def change do
    create table(:loan_applications) do
      add :first_name, :string, null: false
      add :last_name, :string, null: false
      add :amount, :decimal, null: false
      add :phone, :string, size: 20, null: false
      add :email, :string, null: false

      timestamps()
    end
  end
end
