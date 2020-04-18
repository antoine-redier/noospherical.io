defmodule Noospherical.Repo.Migrations.AddSlugToArticles do
  use Ecto.Migration

  def change do
    alter table(:articles) do
      add :slug, :string
    end
  end
end
