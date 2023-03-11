defmodule RepoexWeb.Auth.Pipeline do
  use Guardian.Plug.Pipeline, otp_app: :repoex

  plug Guardian.Plug.VerifyHeader
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end
