defmodule Loany.Loans do
  @moduledoc """
  The Loans context.
  """

  import Ecto.Query, warn: false
  alias Loany.Repo

  alias Loany.Loans.Application

  @doc """
  Returns the list of applications.

  ## Examples

      iex> list_applications()
      [%Application{}, ...]

  """
  def list_applications do
    from(a in Application,
      select_merge: %{rejected: fragment("? < 0", a.interest)}
    )
    |> Repo.all()
  end

  @doc """
  Gets a single application.

  Raises `Ecto.NoResultsError` if the Application does not exist.

  ## Examples

      iex> get_application!(123)
      %Application{}

      iex> get_application!(456)
      ** (Ecto.NoResultsError)

  """
  def get_application!(id) do
    from(a in Application,
      select_merge: %{rejected: fragment("? < 0", a.interest)},
      where: a.id == ^id
    )
    |> Repo.one!()
  end

  @doc """
  Creates a application.

  ## Examples

      iex> create_application(%{field: value})
      {:ok, %Application{}}

      iex> create_application(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_application(attrs \\ %{}) do
    application = Application.changeset(%Application{}, attrs)
    loan_amount = Ecto.Changeset.get_field(application, :loan_amount)

    min =
      case :ets.lookup(:loans, :smallest_loan) do
        [] -> loan_amount
        [smallest_loan: val] -> val
      end

    interest =
      cond do
        loan_amount <= min ->
          :ets.insert(:loans, {:smallest_loan, loan_amount})
          -1.0

        is_prime?(loan_amount) ->
          9.99

        true ->
          (:rand.uniform(9) + 3) / 1
      end

    application
    |> Ecto.Changeset.put_change(:interest, interest)
    |> Repo.insert()
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking application changes.

  ## Examples

      iex> change_application(application)
      %Ecto.Changeset{source: %Application{}}

  """
  def change_application(%Application{} = application),
    do: Application.changeset(application, %{})

  def is_prime?(n) when n in [2, 3], do: true

  def is_prime?(n) do
    floored_sqrt =
      :math.sqrt(n)
      |> Float.floor()
      |> round

    !Enum.any?(2..floored_sqrt, &(rem(n, &1) == 0))
  end
end
