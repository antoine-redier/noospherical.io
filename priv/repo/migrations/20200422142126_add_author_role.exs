defmodule Noospherical.Repo.Migrations.AddAuthorRole do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :author, :boolean, default: false
    end
  end
end
