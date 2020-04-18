defmodule NoosphericalWeb.CommentView do
  use NoosphericalWeb, :view

  alias Noospherical.Articles.Comment

  def format_time(naive) do
    Comment.human_date(naive)
  end
end
