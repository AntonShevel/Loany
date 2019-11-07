defmodule Loany.Repo.Migrations.CreateLoanResolutions do
  use Ecto.Migration

  def change do
    create table(:loan_resolutions) do
      add :status, :string, null: false
      add :rate, :decimal
      add :loan_application_id, references(:loan_applications), null: false

      timestamps()
    end

  end
end
