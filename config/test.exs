import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :repos_find, ReposFind.Repo,
  username: "postgres",
  password: "postgres",
  database: "repos_find_test#{System.get_env("MIX_TEST_PARTITION")}",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

config :repos_find, ReposFind.Repositories.Get, github_repos_adapter: ReposFind.Github.ClientMock

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :repos_find, ReposFindWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "zpgiJqNQNj0u6gZJTiVIa1knnxY6wD38aqG5NoYMwYxsyMfjlLYtUkrXRkNk0L4X",
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
