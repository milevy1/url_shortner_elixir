defmodule UrlShortnerWeb.URLController do
  use UrlShortnerWeb, :controller

  alias UrlShortner.Shortner
  alias UrlShortner.Shortner.URL

  action_fallback UrlShortnerWeb.FallbackController

  def index(conn, _params) do
    urls = Shortner.list_urls()
    render(conn, "index.json", urls: urls)
  end

  def create(conn, %{"url" => url_params}) do
    with {:ok, %URL{} = url} <- Shortner.create_url(url_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.url_path(conn, :show, url))
      |> render("show.json", url: url)
    end
  end

  def show(conn, %{"id" => id}) do
    url = Shortner.get_url!(id)
    render(conn, "show.json", url: url)
  end

  def update(conn, %{"id" => id, "url" => url_params}) do
    url = Shortner.get_url!(id)

    with {:ok, %URL{} = url} <- Shortner.update_url(url, url_params) do
      render(conn, "show.json", url: url)
    end
  end

  def delete(conn, %{"id" => id}) do
    url = Shortner.get_url!(id)

    with {:ok, %URL{}} <- Shortner.delete_url(url) do
      send_resp(conn, :no_content, "")
    end
  end
end
