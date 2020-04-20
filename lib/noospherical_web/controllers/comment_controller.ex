defmodule NoosphericalWeb.CommentController do
  use NoosphericalWeb, :controller

  alias Noospherical.Articles

  def create(conn, %{"comment" => comment_params, "article_id" => article_id}) do
    article = Noospherical.Repo.get(Articles.Article, article_id)

    current_user = conn.assigns.current_user

    Ecto.build_assoc(article, :comments, text: comment_params["text"], user_id: current_user.id)
    |> Noospherical.Repo.insert()

    conn
    |> put_flash(:info, "Comment created")
    |> redirect(to: Routes.article_path(conn, :show, article))
  end
end
