defmodule GothamWeb.Router do
  use GothamWeb, :router

  pipeline :api do
    plug CORSPlug, origin: "*"
    plug :accepts, ["json"]
  end

  scope "/api", GothamWeb do
    pipe_through :api
    resources "/users", UserController, only: [:index, :show, :create, :update, :delete]
    options "/users", UserController, :options
    options "/users/:id", UserController, :options
    post "/login", UserController, :verify_user
    options "/login", UserController, :options
    resources "/teams", TeamController, only: [:index, :show, :create, :update, :delete]
    options "/teams", TeamController, :options
    options "/teams/:id", TeamController, :options
    resources "/clocks", ClockController, only: [:index, :show, :create, :update, :delete]
    # get "/clocks/:team_id", ClockController, :clockbyteamid
    options "/clocks", ClockController, :options
    options "/clocks/:id", ClockController, :options
    options "/clocks/u/:team_id", ClockController, :options
    resources "/hours", HourController, only: [:index, :show, :create, :update, :delete]
    # get "/hours", HourController, :hourbytime
    options "/hours", HourController, :options
    options "/hours/:id", HourController, :options
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through [:fetch_session, :protect_from_forgery]
      live_dashboard "/dashboard", metrics: GothamWeb.Telemetry
    end
  end
end
