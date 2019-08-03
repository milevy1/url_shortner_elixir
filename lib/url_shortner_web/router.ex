defmodule UrlShortnerWeb.Router do
  use UrlShortnerWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", UrlShortnerWeb do
    pipe_through :api
  end
end
