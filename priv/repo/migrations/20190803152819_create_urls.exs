defmodule UrlShortner.Repo.Migrations.CreateUrls do
  use Ecto.Migration

  def change do
    create table(:urls) do
      add :short_url, :string
      add :long_url, :string

      timestamps()
    end

    create unique_index(:urls, [:short_url])
    create unique_index(:urls, [:long_url])
  end
end
