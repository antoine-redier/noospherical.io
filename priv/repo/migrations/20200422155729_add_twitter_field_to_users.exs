defmodule Noospherical.Repo.Migrations.AddTwitterFieldToUsers do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :twitter, :string
    end
  end
end
