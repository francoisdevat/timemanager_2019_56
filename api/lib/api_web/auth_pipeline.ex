defmodule Gotham.Guardian.AuthPipeline do
  use Guardian.Plug.Pipeline, otp_app: :api,
  module: Gotham.Guardian,
  error_handler: Gotham.AuthErrorHandler

  # plug Guardian.Plug.VerifyHeader, realm: "Bearer"
  plug Guardian.Plug.VerifyHeader, claims: %{"typ" => "access"}
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end