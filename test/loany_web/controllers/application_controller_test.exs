defmodule LoanyWeb.ApplicationControllerTest do
  use LoanyWeb.ConnCase

  alias Loany.Loans

  @create_attrs %{
    email: "some@email.com",
    first_name: "some first_name",
    last_name: "some last_name",
    loan_amount: 120,
    phone: "+49239838383"
  }
  @invalid_attrs %{email: nil, first_name: nil, last_name: nil, loan_amount: nil, phone: nil}

  def fixture(:application) do
    {:ok, application} = Loans.create_application(@create_attrs)
    application
  end

  describe "index" do
    test "lists all applications", %{conn: conn} do
      user = %Loany.Users.User{email: "admin@example.com", password: "admin"}

      conn =
        Pow.Plug.assign_current_user(conn, user, otp_app: :loany)
        |> get(Routes.application_path(conn, :index))

      assert html_response(conn, 200) =~ "Listing Applications"
    end

    test "lists all applications without auth redirects to login", %{conn: conn} do
      conn = get(conn, Routes.application_path(conn, :index))

      assert redirected_to(conn) =~ "/backend/session/new"
    end
  end

  describe "new application" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.application_path(conn, :new))
      assert html_response(conn, 200) =~ "Apply for a loan"
    end
  end

  describe "create application" do
    test "redirects to response when data is valid", %{conn: conn} do
      conn = post(conn, Routes.application_path(conn, :create), application: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.application_path(conn, :response, id)

      conn = get(conn, Routes.application_path(conn, :response, id))
      assert html_response(conn, 200) =~ "Try Again!"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.application_path(conn, :create), application: @invalid_attrs)
      assert html_response(conn, 200) =~ "Oops, something went wrong"
    end
  end
end
