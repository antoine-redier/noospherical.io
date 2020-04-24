defmodule Noospherical.Repo.Migrations.CreateVideos do
  use Ecto.Migration

  def change do
    create table(:videos, primary_key: false) do
      add :uuid, :uuid, primary_key: true
      add :url, :string
      add :title, :string
      add :description, :text

      add :user_uuid, references(:users, type: :uuid, column: :uuid, on_delete: :nothing)
      add :category_id, references(:categories)

      timestamps()
    end

    create index(:videos, [:user_uuid])
  end
end
