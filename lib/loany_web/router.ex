defmodule LoanyWeb.Router do
  use LoanyWeb, :router
  use Pow.Phoenix.Router

  pipeline :protected do
    plug Pow.Plug.RequireAuthenticated,
      error_handler: Pow.Phoenix.PlugErrorHandler
  end

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", LoanyWeb do
    pipe_through :browser

    get "/", ApplicationController, :new
    post "/", ApplicationController, :create
    get "/response/:id", ApplicationController, :response
  end

  scope "/backend" do
    pipe_through :browser

    pow_session_routes()
  end

  scope "/backend" do
    pipe_through [:browser, :protected]

    get "/applications", LoanyWeb.ApplicationController, :index
    get "/applications/:id", LoanyWeb.ApplicationController, :show
  end
end
