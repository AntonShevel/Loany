defmodule LoanyWeb.Router do
  use LoanyWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  scope "/", LoanyWeb do
    pipe_through :browser

    resources "/", PageController, only: [:index, :create]
  end
end
