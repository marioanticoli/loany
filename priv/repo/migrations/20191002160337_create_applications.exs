defmodule Loany.Repo.Migrations.CreateApplications do
  use Ecto.Migration

  def change do
    create table(:applications) do
      add :loan_amount, :integer
      add :first_name, :string
      add :last_name, :string
      add :phone, :string
      add :email, :string
      add :interest, :float

      timestamps()
    end
  end
end
