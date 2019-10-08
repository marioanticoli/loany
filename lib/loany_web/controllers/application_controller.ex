defmodule LoanyWeb.ApplicationController do
  use LoanyWeb, :controller

  alias Loany.Loans
  alias Loany.Loans.Application

  def index(conn, _params) do
    applications = Loans.list_applications()
    render(conn, "index.html", applications: applications)
  end

  def new(conn, _params) do
    changeset = Loans.change_application(%Application{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"application" => application_params}) do
    case Loans.create_application(application_params) do
      {:ok, application} ->
        conn
        |> redirect(to: Routes.application_path(conn, :response, application.id))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    application = Loans.get_application!(id)
    render(conn, "show.html", application: application)
  end

  def response(conn, %{"id" => id}) do
    application = Loans.get_application!(id)
    render(conn, "response.html", application: application, refresh: application.rejected)
  end
end
