defmodule UrlShortner.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    # List all child processes to be supervised
    children = [
      # Start the Ecto repository
      UrlShortner.Repo,
      # Start the endpoint when the application starts
      UrlShortnerWeb.Endpoint,
      # Starts a worker by calling: UrlShortner.Worker.start_link(arg)
      # {UrlShortner.Worker, arg},
      {LinkCache.Supervisor, []}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: UrlShortner.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    UrlShortnerWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
