defmodule ReposFind.Repo do
  use Ecto.Repo,
    otp_app: :repos_find,
    adapter: Ecto.Adapters.Postgres
end
