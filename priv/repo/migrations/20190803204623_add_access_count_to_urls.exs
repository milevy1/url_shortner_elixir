defmodule UrlShortner.Repo.Migrations.AddAccessCountToUrls do
  use Ecto.Migration

  def change do
    alter table(:urls) do
      add :access_count, :integer, default: 0
    end
  end
end
