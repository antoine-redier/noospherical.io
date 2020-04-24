defmodule Noospherical.Repo.Migrations.CreateArticles do
  use Ecto.Migration

  def change do
    create table(:articles, primary_key: false) do
      add :uuid, :uuid, primary_key: true
      add :title, :string
      add :body, :text
      add :user_uuid, references(:users, type: :uuid, column: :uuid)

      timestamps()
    end
  end
end
