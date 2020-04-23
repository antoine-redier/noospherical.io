defmodule Noospherical.Repo.Migrations.AddCommentsToVideos do
  use Ecto.Migration

  def change do
    alter table(:comments) do
      modify :text, :text
    end

    create table(:video_comments) do
      add :text, :text
      add :user_id, references(:users, on_delete: :nothing)
      add :video_id, references(:videos, on_delete: :nothing)

      timestamps()
    end

    create index(:video_comments, [:user_id])
    create index(:video_comments, [:video_id])
  end
end
