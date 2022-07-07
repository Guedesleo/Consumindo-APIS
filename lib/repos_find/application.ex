defmodule ReposFind.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      ReposFind.Repo,
      # Start the Telemetry supervisor
      ReposFindWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: ReposFind.PubSub},
      # Start the Endpoint (http/https)
      ReposFindWeb.Endpoint,
      {Guardian.DB.Token.SweeperServer, []}
      # Start a worker by calling: ReposFind.Worker.start_link(arg)
      # {ReposFind.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ReposFind.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ReposFindWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
