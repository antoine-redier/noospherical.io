defmodule Noospherical.Repo.Migrations.AddDescToArticles do
  use Ecto.Migration

  def change do
    alter table(:articles) do
      add :description, :string
    end
  end
end
