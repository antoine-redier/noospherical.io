defmodule NoosphericalWeb.Router do
  use NoosphericalWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug NoosphericalWeb.Auth
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", NoosphericalWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/about", PageController, :about

    resources "/users", UserController do
      resources "/comments", CommentController, only: [:index]
    end

    resources "/sessions", SessionController, only: [:new, :create, :delete]

    resources "/articles", ArticleController do
      resources "/comments", CommentController, only: [:create]
    end

    resources "/videos", VideoController do
      resources "/comments", CommentController, only: [:create]
    end
  end

  scope "/manage", NoosphericalWeb.Auth do
    pipe_through [:browser, :authenticate_user, :authenticate_admin, :authenticate_author]
  end

  # Other scopes may use custom stacks.
  # scope "/api", NoosphericalWeb do
  #   pipe_through :api
  # end
end
