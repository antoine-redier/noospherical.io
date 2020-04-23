# In this file, we load production configuration and secrets
# from environment variables. You can also hardcode secrets,
# although such is generally not recommended and you have to
# remember to add this file to your .gitignore.
use Mix.Config

database_url =
  "postgresql://doadmin:pchmkc2g5dm7uqju@noospherical-db-do-user-6793247-0.a.db.ondigitalocean.com:25060/defaultdb?sslmode=require"

config :noospherical, Noospherical.Repo,
  ssl: true,
  url: database_url,
  pool_size: String.to_integer(System.get_env("POOL_SIZE") || "10")

secret_key_base = "9DkFE23VE73zTL/vckM4aladYm/DIpMg5562APhyRHbNkw2xCCcgC+xrhFhj3p4Q"

config :noospherical, NoosphericalWeb.Endpoint, secret_key_base: secret_key_base

# ## Using releases (Elixir v1.9+)
#
# If you are doing OTP releases, you need to instruct Phoenix
# to start each relevant endpoint:
#
config :noospherical, NoosphericalWeb.Endpoint, server: true
#
# Then you can assemble a release by calling `mix release`.
# See `mix help release` for more information.
