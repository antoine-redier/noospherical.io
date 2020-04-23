defmodule Noospherical.Multimedia.Video do
  use Ecto.Schema
  import Ecto.Changeset

  def upload_directory do
    Application.get_env(:noospherical, :uploads_directory)
  end

  @primary_key {:id, Noospherical.Permalink, autogenerate: true}
  schema "videos" do
    field :url, :string
    field :description, :string
    field :slug, :string
    field :title, :string

    belongs_to :user, Noospherical.Accounts.User
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

  def local_path(id, title) do
    [upload_directory(), "#{id}"]
    |> Path.join()
  end
end
