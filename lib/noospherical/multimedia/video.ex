defmodule Noospherical.Multimedia.Video do
  use Noospherical.Schema
  import Ecto.Changeset

  schema "videos" do
    field :url, :string
    field :description, :string
    field :slug, :string
    field :title, :string

    belongs_to :user, Noospherical.Accounts.User,
      foreign_key: :user_uuid,
      references: :uuid

    belongs_to :category, Noospherical.Articles.Category
    has_many :video_comments, Noospherical.Multimedia.VideoComment

    timestamps()
  end

  @doc false
  def changeset(video, attrs) do
    video
    |> cast(attrs, [
      :title,
      :description,
      :url,
      :category_id
    ])
    |> validate_required([:title, :description, :url])
    |> foreign_key_constraint(:user_uuid)
    |> assoc_constraint(:category)
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
