defmodule UrlShortner.Shortner do
  @moduledoc """
  The Shortner context.
  """

  import Ecto.Query, warn: false
  alias UrlShortner.Repo

  alias UrlShortner.Shortner.URL

  @doc """
  Returns the list of urls.

  ## Examples

      iex> list_urls()
      [%URL{}, ...]

  """
  def list_urls do
    Repo.all(URL)
  end

  @doc """
  Gets a single url.

  Raises `Ecto.NoResultsError` if the Url does not exist.

  ## Examples

      iex> get_url!(123)
      %URL{}

      iex> get_url!(456)
      ** (Ecto.NoResultsError)

  """
  def get_url!(id), do: Repo.get!(URL, id)

  @doc """
  Creates a url.

  ## Examples

      iex> create_url(%{field: value})
      {:ok, %URL{}}

      iex> create_url(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_url(attrs \\ %{}) do
    %URL{}
    |> URL.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a url.

  ## Examples

      iex> update_url(url, %{field: new_value})
      {:ok, %URL{}}

      iex> update_url(url, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_url(%URL{} = url, attrs) do
    url
    |> URL.changeset(attrs)
    |> Repo.update()
  end

  def increment_count(%URL{} = url) do
    new_count = url.access_count + 1

    url
    |> Ecto.Changeset.change(%{access_count: new_count})
    |> Repo.update()
  end

  @doc """
  Deletes a URL.

  ## Examples

      iex> delete_url(url)
      {:ok, %URL{}}

      iex> delete_url(url)
      {:error, %Ecto.Changeset{}}

  """
  def delete_url(%URL{} = url) do
    Repo.delete(url)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking url changes.

  ## Examples

      iex> change_url(url)
      %Ecto.Changeset{source: %URL{}}

  """
  def change_url(%URL{} = url) do
    URL.changeset(url, %{})
  end

  def get_by_short_url(short_url) do
    Repo.get_by(URL, short_url: short_url)
  end
end
