defmodule NoosphericalWeb.CommentController do
  use NoosphericalWeb, :controller

  import Ecto.Query

  alias Noospherical.Articles
  alias Noospherical.Articles.Comment

  def create(conn, %{"comment" => comment_params, "article_id" => article_uuid}) do
    article = Noospherical.Repo.get_by!(Articles.Article, uuid: article_uuid)

    current_user = conn.assigns.current_user

    Ecto.build_assoc(article, :comments,
      text: comment_params["text"],
      user_uuid: current_user.uuid
    )
    |> Noospherical.Repo.insert()

    conn
    |> put_flash(:info, "Comment created")
    |> redirect(to: Routes.article_path(conn, :show, article))
  end

  def create(conn, %{"video_comment" => comment_params, "video_id" => video_uuid}) do
    video = Noospherical.Repo.get_by!(Noospherical.Multimedia.Video, uuid: video_uuid)

    current_user = conn.assigns.current_user

    Ecto.build_assoc(video, :video_comments,
      text: comment_params["text"],
      user_uuid: current_user.uuid
    )
    |> Noospherical.Repo.insert()

    conn
    |> put_flash(:info, "Comment created")
    |> redirect(to: Routes.video_path(conn, :show, video))
  end

  def index(conn, %{"user_id" => user_uuid} = params) do
    article_page =
      from(c in Comment,
        where: c.user_uuid == ^user_uuid
      )
      |> Noospherical.Repo.paginate(params)

    video_page =
      from(c in Noospherical.Multimedia.VideoComment,
        where: c.user_uuid == ^user_uuid
      )
      |> Noospherical.Repo.paginate(params)

    render(conn, "index.html",
      article_comments: article_page.entries,
      article_page: article_page,
      video_comments: video_page.entries,
      video_page: video_page
    )
  end
end
