defmodule Noospherical.Multimedia do
  @moduledoc """
  The Multimedia context.
  """

  import Ecto.Query, warn: false
  alias Noospherical.Repo
  alias Noospherical.Multimedia.Video
  alias Noospherical.Accounts

  def list_videos do
    Repo.all(Video)
  end

  def get_video!(id), do: Repo.get_by!(Video, uuid: id)

  def create_video(%Accounts.User{} = user, attrs \\ %{}) do
    %Video{}
    |> Video.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:user, user)
    |> Repo.insert()
  end

  def update_video(%Video{} = video, attrs) do
    video
    |> Video.changeset(attrs)
    |> Repo.update()
  end

  def delete_video(%Video{} = video) do
    Repo.delete(video)
  end

  def change_video(%Video{} = video) do
    Video.changeset(video, %{})
  end

  def list_user_videos(%Accounts.User{} = user) do
    Video
    |> user_videos_query(user)
    |> Repo.all()
  end

  def get_user_video!(%Accounts.User{} = user, id) do
    Video
    |> user_videos_query(user)
    |> Repo.get_by!(uuid: id)
  end

  defp user_videos_query(query, %Accounts.User{uuid: user_uuid}) do
    from(v in query, where: v.user_uuid == ^user_uuid)
  end
end
