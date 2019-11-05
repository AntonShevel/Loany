defmodule Loany.Repo.Migrations.CreateLoanApplications do
  use Ecto.Migration

  def change do
    create table(:loan_applications) do
      add :first_name, :string
      add :last_name, :string

      timestamps()
    end

  end
end
