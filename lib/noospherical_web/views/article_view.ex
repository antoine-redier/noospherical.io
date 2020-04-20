defmodule NoosphericalWeb.ArticleView do
  use NoosphericalWeb, :view
  import Scrivener.HTML

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
end
