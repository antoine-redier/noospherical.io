defmodule NoosphericalWeb.UserController do
  use NoosphericalWeb, :controller

  import Ecto.Query

  alias Noospherical.Accounts
  alias Noospherical.Accounts.User

  plug :authenticate_user when action in [:show, :edit, :update]

  plug :authenticate_admin when action in [:index, :delete]

  def action(conn, _) do
    args = [conn, conn.params, conn.assigns.current_user]
    apply(__MODULE__, action_name(conn), args)
  end

  def index(conn, _params, _current_user) do
    users = Accounts.list_users()
    render(conn, "index.html", users: users)
  end

  def new(conn, _params, _current_user) do
    changeset = Accounts.change_registration(%User{}, %{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_params}, _current_user) do
    case Accounts.register_user(user_params) do
      {:ok, user} ->
        conn
        |> NoosphericalWeb.Auth.login(user)
        |> put_flash(:info, "#{user.username} created.")
        |> redirect(to: Routes.user_path(conn, :show, user))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}, current_user) do
    user =
      Accounts.get_user!(id)
      |> Noospherical.Repo.preload(:comments)

    render(conn, "show.html", user: user, current_user: current_user)
  end

  def edit(conn, %{"id" => id}, current_user) do
    user = Accounts.get_user!(id)
    changeset = Accounts.change_user(user)
    render(conn, "edit.html", user: user, changeset: changeset, current_user: current_user)
  end

  def update(conn, %{"id" => id, "user" => user_params}, _current_user) do
    user = Accounts.get_user!(id)

    case Accounts.update_user(user, user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User updated successfully.")
        |> redirect(to: Routes.user_path(conn, :show, user))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", user: user, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}, _current_user) do
    user = Accounts.get_user!(id)
    {:ok, _user} = Accounts.delete_user(user)

    conn
    |> put_flash(:info, "User deleted successfully.")
    |> redirect(to: Routes.user_path(conn, :index))
  end
end
