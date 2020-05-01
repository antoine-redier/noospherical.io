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
        style: "width: 175px; box-shadow: 13px 3px 15px 2px rgba(0,0,0,0.8);"
      )
    else
      Phoenix.HTML.Tag.img_tag(
        "http://tinygraphs.com/squares/#{id}?theme=seascape&numcolors=4&size=150&fmt=svg",
        class: "circle",
        style: "width: 175px; box-shadow: 13px 3px 15px 2px rgba(0,0,0,0.8);"
      )
    end
  end

  def get_user_banner(id) do
    img = "uploads/#{id}_banner_thumb.png"

    if File.exists?(img) do
      Phoenix.HTML.Tag.img_tag(img,
        class: "activator waves-light",
        style:
          "width: 100%; z-index: -1; box-shadow: 7px 8px 15px 1px rgba(0,0,0,0.8); filter: opacity(80%); background-image: url(data:image/png;base64,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); background-color:#0094d0;"
      )
    else
      Phoenix.HTML.Tag.img_tag(
        "https://picsum.photos/seed/#{id}/1500/500",
        class: "activator waves-light",
        style:
          "width: 100%; z-index: -1; box-shadow: 7px 8px 15px 1px rgba(0,0,0,0.8); filter: opacity(80%); background-image: url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADIAAAAyCAMAAAAp4XiDAAAAUVBMVEWFhYWDg4N3d3dtbW17e3t1dXWBgYGHh4d5eXlzc3OLi4ubm5uVlZWPj4+NjY19fX2JiYl/f39ra2uRkZGZmZlpaWmXl5dvb29xcXGTk5NnZ2c8TV1mAAAAG3RSTlNAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEAvEOwtAAAFVklEQVR4XpWWB67c2BUFb3g557T/hRo9/WUMZHlgr4Bg8Z4qQgQJlHI4A8SzFVrapvmTF9O7dmYRFZ60YiBhJRCgh1FYhiLAmdvX0CzTOpNE77ME0Zty/nWWzchDtiqrmQDeuv3powQ5ta2eN0FY0InkqDD73lT9c9lEzwUNqgFHs9VQce3TVClFCQrSTfOiYkVJQBmpbq2L6iZavPnAPcoU0dSw0SUTqz/GtrGuXfbyyBniKykOWQWGqwwMA7QiYAxi+IlPdqo+hYHnUt5ZPfnsHJyNiDtnpJyayNBkF6cWoYGAMY92U2hXHF/C1M8uP/ZtYdiuj26UdAdQQSXQErwSOMzt/XWRWAz5GuSBIkwG1H3FabJ2OsUOUhGC6tK4EMtJO0ttC6IBD3kM0ve0tJwMdSfjZo+EEISaeTr9P3wYrGjXqyC1krcKdhMpxEnt5JetoulscpyzhXN5FRpuPHvbeQaKxFAEB6EN+cYN6xD7RYGpXpNndMmZgM5Dcs3YSNFDHUo2LGfZuukSWyUYirJAdYbF3MfqEKmjM+I2EfhA94iG3L7uKrR+GdWD73ydlIB+6hgref1QTlmgmbM3/LeX5GI1Ux1RWpgxpLuZ2+I+IjzZ8wqE4nilvQdkUdfhzI5QDWy+kw5Wgg2pGpeEVeCCA7b85BO3F9DzxB3cdqvBzWcmzbyMiqhzuYqtHRVG2y4x+KOlnyqla8AoWWpuBoYRxzXrfKuILl6SfiWCbjxoZJUaCBj1CjH7GIaDbc9kqBY3W/Rgjda1iqQcOJu2WW+76pZC9QG7M00dffe9hNnseupFL53r8F7YHSwJWUKP2q+k7RdsxyOB11n0xtOvnW4irMMFNV4H0uqwS5ExsmP9AxbDTc9JwgneAT5vTiUSm1E7BSflSt3bfa1tv8Di3R8n3Af7MNWzs49hmauE2wP+ttrq+AsWpFG2awvsuOqbipWHgtuvuaAE+A1Z/7gC9hesnr+7wqCwG8c5yAg3AL1fm8T9AZtp/bbJGwl1pNrE7RuOX7PeMRUERVaPpEs+yqeoSmuOlokqw49pgomjLeh7icHNlG19yjs6XXOMedYm5xH2YxpV2tc0Ro2jJfxC50ApuxGob7lMsxfTbeUv07TyYxpeLucEH1gNd4IKH2LAg5TdVhlCafZvpskfncCfx8pOhJzd76bJWeYFnFciwcYfubRc12Ip/ppIhA1/mSZ/RxjFDrJC5xifFjJpY2Xl5zXdguFqYyTR1zSp1Y9p+tktDYYSNflcxI0iyO4TPBdlRcpeqjK/piF5bklq77VSEaA+z8qmJTFzIWiitbnzR794USKBUaT0NTEsVjZqLaFVqJoPN9ODG70IPbfBHKK+/q/AWR0tJzYHRULOa4MP+W/HfGadZUbfw177G7j/OGbIs8TahLyynl4X4RinF793Oz+BU0saXtUHrVBFT/DnA3ctNPoGbs4hRIjTok8i+algT1lTHi4SxFvONKNrgQFAq2/gFnWMXgwffgYMJpiKYkmW3tTg3ZQ9Jq+f8XN+A5eeUKHWvJWJ2sgJ1Sop+wwhqFVijqWaJhwtD8MNlSBeWNNWTa5Z5kPZw5+LbVT99wqTdx29lMUH4OIG/D86ruKEauBjvH5xy6um/Sfj7ei6UUVk4AIl3MyD4MSSTOFgSwsH/QJWaQ5as7ZcmgBZkzjjU1UrQ74ci1gWBCSGHtuV1H2mhSnO3Wp/3fEV5a+4wz//6qy8JxjZsmxxy5+4w9CDNJY09T072iKG0EnOS0arEYgXqYnXcYHwjTtUNAcMelOd4xpkoqiTYICWFq0JSiPfPDQdnt+4/wuqcXY47QILbgAAAABJRU5ErkJggg==); background-color:#0094d0;"
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
        style: "width: 300px; border-right: 5px solid #d32f2f"
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
