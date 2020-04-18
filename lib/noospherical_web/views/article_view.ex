defmodule NoosphericalWeb.ArticleView do
  use NoosphericalWeb, :view

  def gravatar(email) do
    hash =
      email
      |> String.trim()
      |> String.downcase()
      |> :erlang.md5()
      |> Base.encode16(case: :lower)

    "https://www.gravatar.com/avatar/#{hash}?s=150&d=identicon"
  end

  def markdown(body) do
    Earmark.as_html!(body)
    |> Phoenix.HTML.raw()
  end
end
