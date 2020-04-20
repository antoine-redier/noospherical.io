defmodule Noospherical.Articles.Article do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, Noospherical.Permalink, autogenerate: true}
  schema "articles" do
    field :body, :string
    field :title, :string
    field :slug, :string

    belongs_to :user, Noospherical.Accounts.User
    belongs_to :category, Noospherical.Articles.Category
    has_many :comments, Noospherical.Comment

    timestamps()
  end

  @doc false
  def changeset(article, attrs) do
    article
    |> cast(attrs, [:title, :body, :category_id])
    |> validate_required([:title, :body])
    |> assoc_constraint(:category)
    |> slugify_title()
  end

  defp slugify_title(changeset) do
    case fetch_change(changeset, :title) do
      {:ok, new_title} -> put_change(changeset, :slug, slugify(new_title))
      :error -> changeset
    end
  end

  defp slugify(str) do
    str
    |> String.downcase()
    |> String.replace(~r/[^\w-]+/u, "-")
  end
end
