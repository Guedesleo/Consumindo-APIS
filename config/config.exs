# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :repos_find,
  ecto_repos: [ReposFind.Repo]

config :repos_find, ReposFind.Repositories.Get, github_repos_adapter: ReposFind.Github.Client

config :repos_find, ReposFind.Repo,
  migration_primary_key: [type: :binary_id],
  migration_foreign_key: [type: :binary_id]

config :repos_find, ReposFindWeb.Auth.Guardian,
  issuer: "repos_find",
  secret_key: "pMf78XlCynd00vytPxYr2WQdBCRFSTTu/sQjiu3Bu20Yvf7IsZAOfqUCGt2zfb8t"

config :guardian, Guardian.DB,
  repo: ReposFind.Repo,
  schema_name: "guardian_tokens",
  # token_types: ["refresh_token"],
  sweep_interval: 1

config :repos_find, ReposFindWeb.Auth.Pipeline,
  module: ReposFindWeb.Auth.Guardian,
  error_handler: ReposFindWeb.Auth.ErrorHandler

# Configures the endpoint
config :repos_find, ReposFindWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: ReposFindWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: ReposFind.PubSub,
  live_view: [signing_salt: "NFCbb2OS"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
