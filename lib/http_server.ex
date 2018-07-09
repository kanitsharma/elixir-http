defmodule HttpServer do
  use Application
  require Logger

  def start(_type, _args) do
    port = Application.get_env(:http_server, :cowboy_port, 8000)

    children = [
      Plug.Adapters.Cowboy.child_spec(:http, HttpServer.Router, [], port: port)
    ]

    Logger.info("App Started!")

    Supervisor.start_link(children, strategy: :one_for_one)
  end
end
