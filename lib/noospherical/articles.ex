defmodule Noospherical.Articles do
  @moduledoc """
  The Articles context.
  """

  import Ecto.Query, warn: false
  alias Noospherical.Repo
  alias Noospherical.Articles.Article
  alias Noospherical.Accounts
  alias Noospherical.Articles.Category

  alias Noospherical.Articles.Comment

  @pubsub Noospherical.PubSub
  @topic "comments"

  def subscribe(content_id) do
    Phoenix.PubSub.subscribe(@pubsub, topic(content_id))
  end

  defp topic(content_id), do: "#{@topic}:#{content_id}"

  def list_root_comments do
    from(c in Comment, where: is_nil(c.parent_id), order_by: [asc: :inserted_at])
    |> Repo.all()
  end

  def create_comment(attrs \\ %{}) do
    %Comment{}
    |> Comment.changeset(attrs)
    |> Repo.insert()
    |> preload()
    |> broadcast_new_comment()
  end

  defp preload({:ok, %Comment{} = comment}), do: {:ok, Repo.preload(comment, :children)}
  defp preload({:error, _reason} = err), do: err

  defp broadcast_new_comment({:ok, comment}) do
    Phoenix.PubSub.broadcast_from!(
      @pubsub,
      self(),
      topic("lobby"),
      {__MODULE__, :new_comment, comment}
    )

    {:ok, comment}
  end

  defp broadcast_new_comment({:error, _} = err), do: err

  def fetch_child_comments(parent_ids) do
    from(c in Comment, where: c.parent_id in ^parent_ids)
    |> Repo.all()
    |> Enum.group_by(& &1.parent_id)
  end

  def nested_comments(comments) do
    Comment.nested(comments)
  end

  def change_comment(comment \\ %Comment{}) do
    Comment.changeset(comment, %{})
  end

  @doc """
  Returns the list of articles.

  ## Examples

      iex> list_articles()
      [%Article{}, ...]

  """

  def create_category!(name) do
    Repo.insert!(%Category{name: name}, on_conflict: :nothing)
  end

  def list_alphabetical_categories do
    Category
    |> Category.alphabetical()
    |> Repo.all()
  end

  def list_articles do
    Repo.all(Article)
  end

  @doc """
  Gets a single article.

  Raises `Ecto.NoResultsError` if the Article does not exist.

  ## Examples

  iex> get_article!(123)
  %Article{}

  iex> get_article!(456)
  ** (Ecto.NoResultsError)

  """
  def get_article!(id), do: Repo.get!(Article, id)

  @doc """
  Creates a article.

  ## Examples

  iex> create_article(%{field: value})
  {:ok, %Article{}}

  iex> create_article(%{field: bad_value})
  {:error, %Ecto.Changeset{}}

  """
  def create_article(%Accounts.User{} = user, attrs \\ %{}) do
    %Article{}
    |> Article.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:user, user)
    |> Repo.insert()
  end

  @doc """
  Updates a article.

  ## Examples

  iex> update_article(article, %{field: new_value})
  {:ok, %Article{}}

  iex> update_article(article, %{field: bad_value})
  {:error, %Ecto.Changeset{}}

  """
  def update_article(%Article{} = article, attrs) do
    article
    |> Article.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a article.

  ## Examples

  iex> delete_article(article)
  {:ok, %Article{}}

  iex> delete_article(article)
  {:error, %Ecto.Changeset{}}

  """
  def delete_article(%Article{} = article) do
    Repo.delete(article)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking article changes.

  ## Examples

  iex> change_article(article)
  %Ecto.Changeset{source: %Article{}}

  """
  def change_article(%Article{} = article) do
    Article.changeset(article, %{})
  end

  def list_user_articles(%Accounts.User{} = user) do
    Article
    |> user_articles_query(user)
    |> Repo.all()
  end

  def get_user_article!(%Accounts.User{} = user, id) do
    Article
    |> user_articles_query(user)
    |> Repo.get!(id)
  end

  defp user_articles_query(query, %Accounts.User{id: user_id}) do
    from(v in query, where: v.user_id == ^user_id)
  end
end
