defmodule UrlShortnerWeb.URLView do
  use UrlShortnerWeb, :view
  alias UrlShortnerWeb.URLView

  def render("index.json", %{urls: urls}) do
    %{data: render_many(urls, URLView, "url.json")}
  end

  def render("show.json", %{url: url}) do
    %{data: render_one(url, URLView, "url.json")}
  end

  def render("url.json", %{url: url}) do
    %{
      id: url.id,
      short_url: url.short_url,
      long_url: url.long_url,
      access_count: url.access_count
    }
  end
end
