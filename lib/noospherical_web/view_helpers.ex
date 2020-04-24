defmodule NoosphericalWeb.ViewHelpers do
  def gravatar(email) do
    hash =
      email
      |> String.trim()
      |> String.downcase()
      |> :erlang.md5()
      |> Base.encode16(case: :lower)

    img = "https://www.gravatar.com/avatar/#{hash}?s=150&d=identicon"
    Phoenix.HTML.Tag.img_tag(img, class: "circle")
  end

  def markdown(body) do
    Earmark.as_html!(body)
    |> Phoenix.HTML.raw()
  end

  def get_user_name(id) do
    user = Noospherical.Repo.get!(Noospherical.Accounts.User, id)

    user.name
  end

  def get_user_username(id) do
    user = Noospherical.Repo.get!(Noospherical.Accounts.User, id)

    user.username
  end

  def get_user_avatar(id) do
    user = Noospherical.Repo.get!(Noospherical.Accounts.User, id)

    gravatar(user.email)
  end

  def get_user_twitter(id) do
    user = Noospherical.Repo.get!(Noospherical.Accounts.User, id)

    if user.twitter do
      "<a href='https://twitter.com/#{user.twitter}'><svg class='left' viewBox='650 300 335 350' width='20%' height='20%' xmlns='http://www.w3.org/2000/svg'>
      <path d='
        M 630, 425
        A 195, 195 0 0 1 331, 600
        A 142, 142 0 0 0 428, 570
        A  70,  70 0 0 1 370, 523
        A  70,  70 0 0 0 401, 521
        A  70,  70 0 0 1 344, 455
        A  70,  70 0 0 0 372, 460
        A  70,  70 0 0 1 354, 370
        A 195, 195 0 0 0 495, 442
        A  67,  67 0 0 1 611, 380
        A 117, 117 0 0 0 654, 363
        A  65,  65 0 0 1 623, 401
        A 117, 117 0 0 0 662, 390
        A  65,  65 0 0 1 630, 425
        Z'
        style='fill:white'/>
      </svg>"
      |> Phoenix.HTML.raw()
    end
  end

  def get_article(id) do
    article = Noospherical.Repo.get!(Noospherical.Articles.Article, id)

    article.title
  end

  def get_video(id) do
    video = Noospherical.Repo.get!(Noospherical.Multimedia.Video, id)

    video.title
  end

  def get_article_url(id) do
    "#{id}"
  end

  def get_video_url(id) do
    "#{id}"
  end
end
