defmodule NoosphericalWeb.CommentController do
  use NoosphericalWeb, :controller

  import Ecto.Query

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

  def index(conn, %{"user_id" => user_id} = params) do
    page =
      Ecto.Query.from(c in Noospherical.Comment, where: c.user_id == ^user_id)
      |> Noospherical.Repo.paginate(params)

    render(conn, "index.html", comments: page.entries, page: page)
  end
end
