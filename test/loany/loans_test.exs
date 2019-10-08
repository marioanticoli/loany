defmodule Loany.LoansTest do
  use Loany.DataCase

  alias Loany.Loans

  describe "applications" do
    alias Loany.Loans.Application

    @valid_attrs %{
      email: "some@email.com",
      first_name: "some first_name",
      last_name: "some last_name",
      loan_amount: 120,
      phone: "+3939494949"
    }

    @invalid_attrs %{email: nil, first_name: nil, last_name: nil, loan_amount: nil, phone: nil}

    def application_fixture(attrs \\ %{}) do
      {:ok, application} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Loans.create_application()

      application
    end

    test "list_applications/0 returns all applications" do
      application = %{application_fixture() | rejected: true}
      assert Loans.list_applications() == [application]
    end

    test "get_application!/1 returns the application with given id" do
      application = %{application_fixture() | rejected: true}
      assert Loans.get_application!(application.id) == application
    end

    test "create_application/1 with valid data creates a application" do
      assert {:ok, %Application{} = application} = Loans.create_application(@valid_attrs)
      assert application.email == "some@email.com"
      assert application.first_name == "some first_name"
      assert application.last_name == "some last_name"
      assert application.loan_amount == 120
      assert application.phone == "+3939494949"
    end

    test "create_application/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Loans.create_application(@invalid_attrs)
    end

    test "change_application/1 returns a application changeset" do
      application = application_fixture()
      assert %Ecto.Changeset{} = Loans.change_application(application)
    end
  end
end
