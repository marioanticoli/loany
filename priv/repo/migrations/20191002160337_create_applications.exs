defmodule Loany.Repo.Migrations.CreateApplications do
  use Ecto.Migration

  def change do
    create table(:applications) do
      add :loan_amount, :float
      add :first_name, :string
      add :last_name, :string
      add :phone, :string
      add :email, :string

      timestamps()
    end

  end
end
