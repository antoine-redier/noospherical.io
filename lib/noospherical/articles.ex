defmodule Noospherical.Articles do
  @moduledoc """
  The Articles context.
  """

  import Ecto.Query, warn: false
  alias Noospherical.Repo
  alias Noospherical.Articles.{Article, Comment, Category}
  alias Noospherical.Accounts.User

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
  def create_article(%User{} = user, attrs \\ %{}) do
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

  def list_user_articles(%User{} = user) do
    Article
    |> user_articles_query(user)
    |> Repo.all()
  end

  def get_user_article!(%User{} = user, id) do
    Article
    |> user_articles_query(user)
    |> Repo.get!(id)
  end

  defp user_articles_query(query, %User{id: user_id}) do
    from(v in query, where: v.user_id == ^user_id)
  end
end
