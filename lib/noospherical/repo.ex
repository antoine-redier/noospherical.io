defmodule Noospherical.Repo do
  use Ecto.Repo,
    otp_app: :noospherical,
    adapter: Ecto.Adapters.Postgres

  use Scrivener,
    page_size: 10
end
