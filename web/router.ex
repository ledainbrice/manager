defmodule Manager.Router do
  use Manager.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    #plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Manager do
    pipe_through :browser # Use the default browser stack
    resources "/users", UserController, except: []
    resources "/groups", GroupController, except: []
    resources "/elements", ElementController, except: []
    get "/groups/:id/elements", ElementController, :starter # only element's root

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", Manager do
  #   pipe_through :api
  # end
end
