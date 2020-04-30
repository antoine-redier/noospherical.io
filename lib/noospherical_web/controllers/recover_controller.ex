defmodule NoosphericalWeb.RecoverController do
  use NoosphericalWeb, :controller

  def new(conn, _) do
    render(conn, "new.html")
  end

  def create(conn, %{"email" => email}) do
    case Noospherical.Repo.get_by(Noospherical.Accounts.User, email: email) do
      nil ->
        conn
        |> put_flash(:error, "Invalid email.")
        |> redirect(to: Routes.recover_path(conn, :new))

      user ->
        NoosphericalWeb.Email.recovery_email(user)
        |> NoosphericalWeb.Mailer.deliver_now()

        conn
        |> put_flash(:info, "Reset email sent.")
        |> redirect(to: Routes.recover_path(conn, :new))
    end
  end

  def show(conn, %{"id" => id}) do
    case Phoenix.Token.verify(NoosphericalWeb.Endpoint, "salt", id, max_age: 86400) do
      {:ok, user_uuid} ->
        user = Noospherical.Repo.get_by!(Noospherical.Accounts.User, uuid: user_uuid)

        changeset = Noospherical.Accounts.change_user(user)

        conn
        |> NoosphericalWeb.Auth.login(user)
        |> render("show.html", user: user, changeset: changeset)

      _ ->
        conn
        |> put_flash(:error, "This reset link has expired.")
        |> render("new.html")
    end
  end
end
