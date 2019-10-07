defmodule Loany.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application
  import Ecto.Query

  def start(_type, _args) do
    # Create ETS
    :ets.new(:loans, [:set, :protected, :named_table])

    # access DB for smallest loan amount (useful if the server is stopped)
    min =
      case from(a in Loany.Loans.Application, select: min(a.loan_amount)) |> Loany.Repo.one() do
        nil -> 0
        val -> val
      end

    :ets.insert(:loans, {:smallest_loan, min})

    # List all child processes to be supervised
    children = [
      # Start the Ecto repository
      Loany.Repo,
      # Start the endpoint when the application starts
      LoanyWeb.Endpoint
      # Starts a worker by calling: Loany.Worker.start_link(arg)
      # {Loany.Worker, arg},
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Loany.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    LoanyWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
