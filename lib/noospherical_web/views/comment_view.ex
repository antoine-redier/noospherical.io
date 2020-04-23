defmodule NoosphericalWeb.CommentView do
  use NoosphericalWeb, :view
  import Scrivener.HTML

  def get_article(id) do
    article = Noospherical.Repo.get!(Noospherical.Articles.Article, id)

    article.title
  end

  def get_video(id) do
    video = Noospherical.Repo.get!(Noospherical.Multimedia.Video, id)

    video.title
  end

  def get_article_url(id) do
    article = Noospherical.Repo.get!(Noospherical.Articles.Article, id)

    "#{id}-#{article.slug}"
  end

  def get_video_url(id) do
    video = Noospherical.Repo.get!(Noospherical.Multimedia.Video, id)

    "#{id}-#{video.slug}"
  end

  def gravatar(email) do
    hash =
      email
      |> String.trim()
      |> String.downcase()
      |> :erlang.md5()
      |> Base.encode16(case: :lower)

    img = "https://www.gravatar.com/avatar/#{hash}?s=150&d=identicon"
    img_tag(img, class: "circle")
  end
end
