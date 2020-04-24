defmodule Noospherical.Repo.Migrations.CreateComments do
  use Ecto.Migration

  def change do
    create table(:comments, primary_key: false) do
      add :uuid, :uuid, primary_key: true
      add :text, :string
      add :user_uuid, references(:users, type: :uuid, column: :uuid, on_delete: :nothing)
      add :article_uuid, references(:articles, type: :uuid, column: :uuid, on_delete: :nothing)

      timestamps()
    end

    create index(:comments, [:user_uuid])
    create index(:comments, [:article_uuid])
  end
end
