defmodule Noospherical.Repo.Migrations.CreateImages do
  use Ecto.Migration

  def change do
    create table(:images) do
      add :image, :string

      timestamps()
    end
  end
end
