import Config

config :noospherical, Noospherical.Repo,
  ssl: true,
  hostname: System.get_env("DB_HOST"),
  username: System.get_env("DB_USER"),
  database: System.get_env("DB_NAME"),
  password: System.get_env("DB_PASSWD"),
  port: System.get_env("DB_PORT"),
  pool_size: 15

config :noospherical, NoosphericalWeb.Endpoint,
  force_ssl: [hsts: true],
  url: [host: "noospherical.io", port: 443, scheme: "https"],
  http: [:inet6, port: 80],
  https: [
    port: 443,
    otp_app: :noospherical,
    cipher_suite: :strong,
    keyfile: "/path/to/privkey.pem",
    certfile: "/path/to/fullchain.pem",
    transport_options: [socket_opts: [:inet6]]
  ],
  cache_static_manifest: "priv/static/cache_manifest.json"

config :logger, level: :info

config :noospherical, NoosphericalWeb.Endpoint, force_ssl: [hsts: true]

config :noospherical, NoosphericalWeb.Endpoint, server: true
