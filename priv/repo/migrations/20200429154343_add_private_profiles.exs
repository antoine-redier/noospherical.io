defmodule Noospherical.Repo.Migrations.AddPrivateProfiles do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :private, :boolean, default: false
    end
  end
end
