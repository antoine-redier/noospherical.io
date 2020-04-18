defmodule Noospherical.Repo do
  use Ecto.Repo,
    otp_app: :noospherical,
    adapter: Ecto.Adapters.Postgres
end
