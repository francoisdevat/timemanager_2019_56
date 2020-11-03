defmodule GothamWeb.Router do
  use GothamWeb, :router

  pipeline :api do
    plug CORSPlug, origin: "*"
    plug :accepts, ["json"]
  end

  pipeline :jwt_authenticated do
    plug CORSPlug, origin: "*"
    plug Gotham.Guardian.AuthPipeline
  end

  scope "/api", GothamWeb do
    pipe_through :api
    # Créer un user
    resources "/users", UserController, only: [:create]
    options "/users", UserController, :options
    # Connexion
    post "/login", UserController, :sign_in
    options "/login", UserController, :options
    # Créer une team
    resources "/teams", TeamController, only: [:create]
    options "/teams", TeamController, :options
    # Créer des horaires
    resources "/hours", HourController, only: [:create]
    options "/hours", HourController, :options
    # Créer des droits
    resources "/rights", RightController, only: [:create]
    options "/rights", RightController, :options

    ##########
    # Voir tous les users, update user, delete user
    resources "/users", UserController, only: [:index, :update, :delete]
    get "/users/:id", UserController, :user_by_id
    options "/users", UserController, :options 
    options "/users/:id", UserController, :options

    # CRUD teams
    resources "/teams", TeamController, only: [:index, :show, :create, :update, :delete]
    options "/teams", TeamController, :options
    options "/teams/:id", TeamController, :options

    # CRUD pointages
    resources "/clocks", ClockController, only: [:index, :show, :create, :update, :delete]
    get "/lastclock/:user_id", ClockController, :lastclock
    get "/myclocks/:user_id", ClockController, :clockbyuser
    options "/clocks", ClockController, :options
    options "/myclocks/:user_id", ClockController, :options
    options "/lastclock/:user_id", ClockController, :options
    options "/clocks/:id", ClockController, :options

    # CRUD hours
    resources "/hours", HourController, only: [:index, :show, :create, :update, :delete]
    options "/hours", HourController, :options
    options "/hours/:id", HourController, :options
    # Voir les horaires sur une plage spécifique /hour?start=X&end=Y    
    get "/hour", HourController, :hourbytime
    # Voir les horaires d'un user
    get "/myhours/:user_id", HourController, :hourbyuser
    options "/myhours/:user_id", HourController, :options
    # Voir les horaires d'une team
    get "/teamhours/:team_id", HourController, :hourbyteam
    options "/teamhours/:team_id", HourController, :options


    # Voir les droits, update les droits, delete les droits
    resources "/rights", RightController, only: [:index, :show, :update, :delete]
    options "/rights", RightController, :options
    options "/rights/:id", RightController, :options
  end

  scope "/api/", GothamWeb do
    # Routes nécessitant d'être connecté (Authorization + Token sur Postman / être connecté sur l'appli)
    pipe_through [:api, :jwt_authenticated]

    # Récupérer un user
    get "/my_user", UserController, :show
    options "/my_user", UserController, :options

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
