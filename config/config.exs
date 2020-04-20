# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :noospherical,
  ecto_repos: [Noospherical.Repo]

# Configures the endpoint
config :noospherical, NoosphericalWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "mmqYLjPVMkbpB0xeEvKqUSq2HgworEQdedcUJInS1xvk96ediLcdvUs6TzHXA0fw",
  render_errors: [view: NoosphericalWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Noospherical.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [signing_salt: "ci1cGxWn"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
