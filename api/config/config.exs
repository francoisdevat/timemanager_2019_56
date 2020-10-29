# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :api,
  namespace: Gotham,
  ecto_repos: [Gotham.Repo],
  generators: [binary_id: true]

# Configures the endpoint
config :api, GothamWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "nIUzRAQJr2upkJMvr66ePoYHSCQmK3X014RnTQoVPopeMGaOSnbZ1uZHgIYob63P",
  render_errors: [view: GothamWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Gotham.PubSub,
  live_view: [signing_salt: "kiGt6tSM"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :api, Gotham.Guardian,
 issuer: "Gotham",
 secret_key: "uH9hqeesF3wSTWfMuQDeok6+AYJib3eZC/o+bXEv5WMwd9hDEIO0GqsXHPfoVC5I",
 serializer: Gotham.GuardianSerializer

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
