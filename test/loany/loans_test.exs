defmodule Loany.LoansTest do
  use Loany.DataCase

  alias Loany.Loans

  describe "applications" do
    alias Loany.Loans.Application

    @valid_attrs %{email: "some email", first_name: "some first_name", last_name: "some last_name", loan_amount: 120.5, phone: "some phone"}
    @update_attrs %{email: "some updated email", first_name: "some updated first_name", last_name: "some updated last_name", loan_amount: 456.7, phone: "some updated phone"}
    @invalid_attrs %{email: nil, first_name: nil, last_name: nil, loan_amount: nil, phone: nil}

    def application_fixture(attrs \\ %{}) do
      {:ok, application} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Loans.create_application()

      application
    end

    test "list_applications/0 returns all applications" do
      application = application_fixture()
      assert Loans.list_applications() == [application]
    end

    test "get_application!/1 returns the application with given id" do
      application = application_fixture()
      assert Loans.get_application!(application.id) == application
    end

    test "create_application/1 with valid data creates a application" do
      assert {:ok, %Application{} = application} = Loans.create_application(@valid_attrs)
      assert application.email == "some email"
      assert application.first_name == "some first_name"
      assert application.last_name == "some last_name"
      assert application.loan_amount == 120.5
      assert application.phone == "some phone"
    end

    test "create_application/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Loans.create_application(@invalid_attrs)
    end

    test "update_application/2 with valid data updates the application" do
      application = application_fixture()
      assert {:ok, %Application{} = application} = Loans.update_application(application, @update_attrs)
      assert application.email == "some updated email"
      assert application.first_name == "some updated first_name"
      assert application.last_name == "some updated last_name"
      assert application.loan_amount == 456.7
      assert application.phone == "some updated phone"
    end

    test "update_application/2 with invalid data returns error changeset" do
      application = application_fixture()
      assert {:error, %Ecto.Changeset{}} = Loans.update_application(application, @invalid_attrs)
      assert application == Loans.get_application!(application.id)
    end

    test "delete_application/1 deletes the application" do
      application = application_fixture()
      assert {:ok, %Application{}} = Loans.delete_application(application)
      assert_raise Ecto.NoResultsError, fn -> Loans.get_application!(application.id) end
    end

    test "change_application/1 returns a application changeset" do
      application = application_fixture()
      assert %Ecto.Changeset{} = Loans.change_application(application)
    end
  end
end
