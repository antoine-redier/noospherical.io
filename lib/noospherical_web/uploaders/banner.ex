defmodule NoosphericalWeb.Banner do
  use Arc.Definition
  use Arc.Ecto.Definition

  def __storage, do: Arc.Storage.Local

  @versions [:sidenav, :thumb]

  def validate({file, _}) do
    ~w(.jpg .jpeg .gif .png) |> Enum.member?(Path.extname(file.file_name))
  end

  def transform(:thumb, _) do
    {:convert, "-strip -thumbnail 1500x500^ -gravity center -extent 1500x500 -format png", :png}
  end

  def transform(:sidenav, _) do
    {:convert, "-strip -thumbnail 300x220^ -gravity center -extent 300x220 -format png", :png}
  end

  # Override the persisted filenames:
  def filename(version, {_file, scope}) do
    "#{scope}_banner_#{version}"
  end
end
