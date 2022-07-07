defmodule ReposFindWeb.Auth.Pipeline do
  use Guardian.Plug.Pipeline, otp_app: :repos_find

  plug Guardian.Plug.VerifyHeader
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end
