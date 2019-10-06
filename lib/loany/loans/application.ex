defmodule Loany.Loans.Application do
  use Ecto.Schema
  import Ecto.Changeset

  schema "applications" do
    field :email, :string
    field :first_name, :string
    field :last_name, :string
    field :loan_amount, :float
    field :phone, :string

    timestamps()
  end

  @doc false
  def changeset(application, attrs) do
    application
    |> cast(attrs, [:loan_amount, :first_name, :last_name, :phone, :email])
    |> validate_required([:loan_amount, :first_name, :last_name, :phone, :email])
  end
end
