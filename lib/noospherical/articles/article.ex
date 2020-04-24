defmodule Noospherical.Articles.Article do
  use Noospherical.Schema
  import Ecto.Changeset

  schema "articles" do
    field :body, :string
    field :title, :string
    field :slug, :string

    belongs_to :user, Noospherical.Accounts.User,
      foreign_key: :user_uuid,
      references: :uuid

    belongs_to :category, Noospherical.Category
    has_many :comments, Noospherical.Articles.Comment

    timestamps()
  end

  @doc false
  def changeset(article, attrs) do
    article
    |> cast(attrs, [:title, :body, :category_id])
    |> validate_required([:title, :body])
    |> foreign_key_constraint(:user_uuid)
    |> assoc_constraint(:category)
  end
end
