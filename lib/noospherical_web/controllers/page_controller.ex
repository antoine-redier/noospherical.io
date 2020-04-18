defmodule NoosphericalWeb.PageController do
  use NoosphericalWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
