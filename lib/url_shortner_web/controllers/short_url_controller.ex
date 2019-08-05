defmodule UrlShortnerWeb.ShortURLController do
  use UrlShortnerWeb, :controller

  alias UrlShortner.Shortner

  action_fallback UrlShortnerWeb.FallbackController

  def show(conn, %{"short_url" => short_url}) do
    # url =
    #   LinkCache.Cache.fetch(
    #     short_url,
    #     fn -> Shortner.get_by_short_url(short_url) end
    #   )

    url = Shortner.get_by_short_url(short_url)
    Shortner.increment_count(url)

    redirect(conn, external: url.long_url)
  end
end
