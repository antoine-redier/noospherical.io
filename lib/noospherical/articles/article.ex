defmodule Noospherical.Articles.Article do
  use Noospherical.Schema
  import Ecto.Changeset

  schema "articles" do
    field :body, :string
    field :description, :string
    field :title, :string

    belongs_to :user, Noospherical.Accounts.User,
      foreign_key: :user_uuid,
      references: :uuid

    belongs_to :category, Noospherical.Category,
      foreign_key: :category_id,
      references: :id,
      type: :integer

    has_many :comments, Noospherical.Articles.Comment

    timestamps()
  end

  @doc false
  def changeset(article, attrs) do
    article
    |> cast(attrs, [:title, :body, :description, :category_id])
    |> validate_required([:title, :body])
    |> validate_length(:description, max: 200)
    |> foreign_key_constraint(:user_uuid)
    |> assoc_constraint(:category)
  end
end
