defmodule UrlShortner.Shortner.URL do
  use Ecto.Schema
  import Ecto.Changeset

  schema "urls" do
    field :long_url, :string
    field :short_url, :string
    field :access_count, :integer

    timestamps()
  end

  @doc false
  def changeset(url, attrs) do
    url
    |> cast(attrs, [:short_url, :long_url, :access_count])
    |> validate_required([:short_url, :long_url])
    |> unique_constraint(:short_url)
    |> unique_constraint(:long_url)
    |> validate_uris(:long_url)
  end

  defp validate_uris(%{changes: changes} = changeset, field) do
    with {:ok, long_url} <- Map.fetch(changes, field),
         parsed_url <- URI.parse(long_url),
         {:ok, _parsed_url} <- valid_host_and_scheme?(parsed_url) do
      changeset
    else
      _ -> changeset |> add_error(field, "Invalid URI")
    end
  end

  defp valid_host_and_scheme?(%URI{host: _host, scheme: nil} = parsed_url),
    do: {:error, parsed_url}

  defp valid_host_and_scheme?(%URI{host: nil, scheme: _scheme} = parsed_url),
    do: {:error, parsed_url}

  defp valid_host_and_scheme?(%URI{host: _host, scheme: _scheme} = parsed_url) do
    {:ok, parsed_url}
  end
end
