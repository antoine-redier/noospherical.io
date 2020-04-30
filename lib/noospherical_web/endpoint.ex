defmodule NoosphericalWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :noospherical

  # The session will be stored in the cookie and signed,
  # this means its contents can be read but not tampered with.
  # Set :encryption_salt if you would also like to encrypt it.
  @session_options [
    store: :cookie,
    key: "_noospherical_key",
    signing_salt: "16W9fw+c"
  ]

  socket "/socket", NoosphericalWeb.UserSocket,
    websocket: true,
    longpoll: false

  # Serve at "/" the static files from "priv/static" directory.
  #
  # You should set gzip to true if you are running phx.digest
  # when deploying your static files in production.
  plug Plug.Static,
    at: "/",
    from: :noospherical,
    gzip: false,
    only: ~w(css fonts images js favicon.ico robots.txt)

  plug Plug.Static,
    at: "/uploads",
    from: Path.expand('./uploads'),
    gzip: false

  plug Plug.Static,
    at: "/users/uploads",
    from: Path.expand('./uploads'),
    gzip: false

  plug Plug.Static,
    at: "/about/uploads",
    from: Path.expand('./uploads'),
    gzip: false

  plug Plug.Static,
    at: "/articles/uploads",
    from: Path.expand('./uploads'),
    gzip: false

  plug Plug.Static,
    at: "/videos/uploads",
    from: Path.expand('./uploads'),
    gzip: false

  # Code reloading can be explicitly enabled under the
  # :code_reloader configuration of your endpoint.
  if code_reloading? do
    socket "/phoenix/live_reload/socket", Phoenix.LiveReloader.Socket
    plug Phoenix.LiveReloader
    plug Phoenix.CodeReloader
  end

  plug Plug.RequestId
  plug Plug.Telemetry, event_prefix: [:phoenix, :endpoint]

  plug Plug.Parsers,
    parsers: [:urlencoded, {:multipart, length: 8_741_824}, :json],
    pass: ["*/*"],
    json_decoder: Phoenix.json_library()

  plug Plug.MethodOverride
  plug Plug.Head
  plug Plug.Session, @session_options
  plug NoosphericalWeb.Router
end
