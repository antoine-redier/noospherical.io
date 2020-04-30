defmodule Noospherical.Uploads.Image do
  use Arc.Ecto.Schema
  use Ecto.Schema
  import Ecto.Changeset

  schema "images" do
    field :image, NoosphericalWeb.Avatar.Type

    timestamps()
  end

  @doc false
  def changeset(image, attrs \\ %{}) do
    image
    |> cast(attrs, [:image])
    |> validate_required([:image])
  end
end
