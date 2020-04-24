defmodule Noospherical.Multimedia.VideoComment do
  use Noospherical.Schema
  import Ecto.Changeset

  schema "video_comments" do
    field :text, :string
    field :user_uuid, :binary_id
    field :video_uuid, :binary_id

    timestamps()
  end

  @doc false
  def changeset(comment, attrs \\ %{}) do
    comment
    |> cast(attrs, [:text])
    |> validate_required([:text])
  end
end
