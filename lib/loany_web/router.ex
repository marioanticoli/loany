defmodule LoanyWeb.Router do
  use LoanyWeb, :router

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
    get "/applications", ApplicationController, :index
    get "/applications/:id", ApplicationController, :show
  end
end
