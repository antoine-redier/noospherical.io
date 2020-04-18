defmodule Noospherical.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :age, :string
      add :gender, :string
      add :username, :string
      add :password_hash, :string
      add :email, :string

      timestamps()
    end

    create unique_index(:users, [:username])
  end
end
