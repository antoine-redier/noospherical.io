defmodule Noospherical.Repo.Migrations.CreateArticles do
  use Ecto.Migration

  def change do
    create table(:articles) do
      add :title, :string
      add :body, :text
      add :user_id, references(:users)

      timestamps()
    end
  end
end
