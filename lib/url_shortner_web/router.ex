defmodule UrlShortnerWeb.Router do
  use UrlShortnerWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", UrlShortnerWeb do
    pipe_through :api

    resources "/urls", URLController, except: [:new, :edit]
  end

  scope "/", UrlShortnerWeb do
    get "/:short_url", ShortURLController, :show
    get "/:short_url/stats", URLController, :stats
  end
end
