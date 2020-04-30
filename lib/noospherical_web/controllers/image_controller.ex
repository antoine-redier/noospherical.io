defmodule NoosphericalWeb.ImageController do
  use NoosphericalWeb, :controller

  alias Noospherical.Uploads
  alias Noospherical.Uploads.Image

  def action(conn, _) do
    args = [conn, conn.params, conn.assigns.current_user]
    apply(__MODULE__, action_name(conn), args)
  end

  def index(conn, _params, current_user) do
    users = Noospherical.Repo.all(Noospherical.Accounts.User)
    render(conn, "index.html", users: users)
  end

  def create(conn, %{"image" => image_params}, current_user) do
    case NoosphericalWeb.Avatar.store({image_params["image"], current_user.uuid}) do
      {:ok, image} ->
        conn
        |> put_flash(:info, "Image created successfully.")
        |> redirect(to: "/users/#{current_user.uuid}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def create_banner(conn, %{"image" => image_params}, current_user) do
    case NoosphericalWeb.Banner.store({image_params["image"], current_user.uuid}) do
      {:ok, image} ->
        conn
        |> put_flash(:info, "Image created successfully.")
        |> redirect(to: "/users/#{current_user.uuid}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new_banner.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => image}, current_user) do
    render(conn, "show.html", image: image, current_user: current_user)
  end

  def edit(conn, %{"id" => id}, current_user) do
    image = Uploads.get_image!(id)
    changeset = Uploads.change_image(image)
    render(conn, "edit.html", image: image, changeset: changeset)
  end

  def update(conn, %{"id" => id, "image" => image_params}, current_user) do
    image = Uploads.get_image!(id)

    case Uploads.update_image(image, image_params) do
      {:ok, image} ->
        conn
        |> put_flash(:info, "Image updated successfully.")
        |> redirect(to: Routes.image_path(conn, :show, image))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", image: image, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    image = Uploads.get_image!(id)
    {:ok, _image} = Uploads.delete_image(image)

    conn
    |> put_flash(:info, "Image deleted successfully.")
    |> redirect(to: Routes.image_path(conn, :index))
  end
end
