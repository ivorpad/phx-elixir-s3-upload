defmodule ApiUploader.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      ApiUploaderWeb.Telemetry,
      # Start the Ecto repository
      # Start the PubSub system
      {Phoenix.PubSub, name: ApiUploader.PubSub},
      # Start Finch
      {Finch, name: ApiUploader.Finch},
      # Start the Endpoint (http/https)
      ApiUploaderWeb.Endpoint,
      # Start a worker by calling: ApiUploader.Worker.start_link(arg)
      # {ApiUploader.Worker, arg}

      # Start the S3 Uploader Manager
      ApiUploader.S3UploaderManager
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ApiUploader.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ApiUploaderWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
