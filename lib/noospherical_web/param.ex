defimpl Phoenix.Param,
  for: [Noospherical.Articles.Article, Noospherical.Multimedia.Video] do
  def to_param(%{slug: slug, id: id}) do
    "#{id}-#{slug}"
  end
end
