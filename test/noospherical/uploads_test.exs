defmodule Noospherical.UploadsTest do
  use Noospherical.DataCase

  alias Noospherical.Uploads

  describe "images" do
    alias Noospherical.Uploads.Image

    @valid_attrs %{image: "some image"}
    @update_attrs %{image: "some updated image"}
    @invalid_attrs %{image: nil}

    def image_fixture(attrs \\ %{}) do
      {:ok, image} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Uploads.create_image()

      image
    end

    test "list_images/0 returns all images" do
      image = image_fixture()
      assert Uploads.list_images() == [image]
    end

    test "get_image!/1 returns the image with given id" do
      image = image_fixture()
      assert Uploads.get_image!(image.id) == image
    end

    test "create_image/1 with valid data creates a image" do
      assert {:ok, %Image{} = image} = Uploads.create_image(@valid_attrs)
      assert image.image == "some image"
    end

    test "create_image/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Uploads.create_image(@invalid_attrs)
    end

    test "update_image/2 with valid data updates the image" do
      image = image_fixture()
      assert {:ok, %Image{} = image} = Uploads.update_image(image, @update_attrs)
      assert image.image == "some updated image"
    end

    test "update_image/2 with invalid data returns error changeset" do
      image = image_fixture()
      assert {:error, %Ecto.Changeset{}} = Uploads.update_image(image, @invalid_attrs)
      assert image == Uploads.get_image!(image.id)
    end

    test "delete_image/1 deletes the image" do
      image = image_fixture()
      assert {:ok, %Image{}} = Uploads.delete_image(image)
      assert_raise Ecto.NoResultsError, fn -> Uploads.get_image!(image.id) end
    end

    test "change_image/1 returns a image changeset" do
      image = image_fixture()
      assert %Ecto.Changeset{} = Uploads.change_image(image)
    end
  end
end
