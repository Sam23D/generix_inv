defmodule GenerixInvWeb.Router do
  use GenerixInvWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", GenerixInvWeb do
    pipe_through :browser 

    get "/", PageController, :index
  end

  scope "/api", GenerixInvWeb do
    pipe_through :api

    post "/items/check", ItemController, :update_inventory
    resources "/items", ItemController, except: [:new, :edit]
    resources "/historical_items", HistoricalItemController, except: [:new, :edit]
  end
end
