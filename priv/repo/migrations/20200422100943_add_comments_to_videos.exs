defmodule Noospherical.Repo.Migrations.AddCommentsToVideos do
  use Ecto.Migration

  def change do
    alter table(:comments) do
      modify :text, :text
    end

    create table(:video_comments, primary_key: false) do
      add :uuid, :uuid, primary_key: true
      add :text, :text
      add :user_uuid, references(:users, type: :uuid, column: :uuid, on_delete: :nothing)
      add :video_uuid, references(:videos, type: :uuid, column: :uuid, on_delete: :nothing)

      timestamps()
    end

    create index(:video_comments, [:user_uuid])
    create index(:video_comments, [:video_uuid])
  end
end
