defmodule Noospherical.Accounts.User do
  use Noospherical.Schema
  import Ecto.Changeset

  schema "users" do
    field :name, :string
    field :age, :string
    field :gender, :string
    field :twitter, :string
    field :email, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    field :username, :string
    field :admin, :boolean, default: false
    field :author, :boolean, default: false

    has_many :articles, Noospherical.Articles.Article
    has_many :comments, Noospherical.Articles.Comment
    has_many :video_comments, Noospherical.Multimedia.VideoComment

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :email, :name, :age, :gender, :twitter])
    |> validate_required([:username, :email])
    |> validate_length(:username, min: 3, max: 20)
    |> unique_constraint([:username, :email])
  end

  def registration_changeset(user, params) do
    user
    |> changeset(params)
    |> cast(params, [:password], [])
    |> validate_length(:password, min: 8, max: 100)
    |> put_pass_hash()
  end

  def put_pass_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
        put_change(changeset, :password_hash, Pbkdf2.hash_pwd_salt(pass))

      _ ->
        changeset
    end
  end
end
