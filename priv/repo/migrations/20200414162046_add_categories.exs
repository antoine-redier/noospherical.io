defmodule Noospherical.Repo.Migrations.AddCategories do
  use Ecto.Migration

  def change do
    create table(:categories) do
      add :name, :string, null: false

      timestamps()
    end

    create unique_index(:categories, [:name])

    alter table(:articles) do
      add :category_id, references(:categories)
    end
  end
end
