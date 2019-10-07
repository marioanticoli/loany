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
    |> validate_number(:loan_amount, greater_than: 0)
    |> validate_length(:first_name, min: 1)
    |> validate_length(:last_name, min: 1)
    |> validate_format(:phone, ~r/\+[0-9]{6,11}/,
      message: "Please enter your number starting with a + followed by only numbers"
    )
    |> validate_format(:email, ~r/[^@]+@[^\.]+\..+/,
      message: "Please enter your email like username@domain.tld"
    )
  end
end
