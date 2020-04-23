defmodule Noospherical.Multimedia.VideoComment do
  use Ecto.Schema
  import Ecto.Changeset

  schema "video_comments" do
    field :text, :string
    field :user_id, :id
    field :video_id, :id

    timestamps()
  end

  @doc false
  def changeset(comment, attrs \\ %{}) do
    comment
    |> cast(attrs, [:text, :parent_id])
    |> validate_required([:text])
  end
end
