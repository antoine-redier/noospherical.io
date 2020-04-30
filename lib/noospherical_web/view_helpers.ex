defmodule NoosphericalWeb.ViewHelpers do
  def markdown(body) do
    Phoenix.HTML.raw(body)
  end

  def get_category(id) do
    category = Noospherical.Repo.get!(Noospherical.Category, id)

    category.name
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
    img = "uploads/#{id}_thumb.png"

    if File.exists?(img) do
      Phoenix.HTML.Tag.img_tag(img,
        class: "circle",
        style: "width: 150px; height: 100%; box-shadow: 13px 3px 15px 2px rgba(0,0,0,0.8);"
      )
    else
      Phoenix.HTML.Tag.img_tag(
        "http://tinygraphs.com/squares/#{id}?theme=seascape&numcolors=4&size=150&fmt=svg",
        class: "circle",
        style:
          "width: 150px; height: 100%; background: black; box-shadow: 13px 3px 15px 2px rgba(0,0,0,0.8);"
      )
    end
  end

  def get_user_banner(id) do
    img = "uploads/#{id}_banner_thumb.png"

    if File.exists?(img) do
      Phoenix.HTML.Tag.img_tag(img,
        class: "activator waves-light",
        style:
          "width: 100%; z-index: -1; box-shadow: 0px 7px 10px 0px rgba(0,0,0,0.8); filter: opacity(90%)"
      )
    else
      Phoenix.HTML.Tag.img_tag(
        "https://picsum.photos/seed/#{id}/1500/500",
        class: "activator waves-light",
        style:
          "width: 100%; z-index: -1; box-shadow: 0px 7px 10px 0px rgba(0,0,0,0.8); filter: opacity(90%)"
      )
    end
  end

  def get_sidenav_banner(id) do
    img = "uploads/#{id}_banner_sidenav.png"

    if File.exists?(img) do
      Phoenix.HTML.Tag.img_tag(img,
        class: "activator waves-light",
        style:
          "z-index: -1; box-shadow: 0px 7px 10px 0px rgba(0,0,0,0.8); filter: blur(2px) opacity(60%)"
      )
    else
      Phoenix.HTML.Tag.img_tag(
        "https://picsum.photos/seed/#{id}/300/200",
        class: "activator waves-light",
        style:
          " z-index: -1; box-shadow: 0px 7px 10px 0px rgba(0,0,0,0.8); filter: blur(2px) opacity(60%)"
      )
    end
  end

  def get_author_avatar(id) do
    img = "uploads/#{id}_thumb.png"

    if File.exists?(img) do
      Phoenix.HTML.Tag.img_tag(img,
        class: "circle",
        style: "width: 150px; height: 100%"
      )
    else
      Phoenix.HTML.Tag.img_tag(
        "http://tinygraphs.com/squares/#{id}?theme=seascape&numcolors=4&size=220&fmt=svg",
        class: "circle"
      )
    end
  end

  def get_sidenav_avatar(id) do
    img = "uploads/#{id}_thumb.png"

    if File.exists?(img) do
      Phoenix.HTML.Tag.img_tag(img,
        class: "circle",
        style: "width: 100px; height: 100%"
      )
    else
      Phoenix.HTML.Tag.img_tag(
        "http://tinygraphs.com/squares/#{id}?theme=seascape&numcolors=4&size=220&fmt=svg",
        class: "circle",
        style: "width: 100px; height: 100%"
      )
    end
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
