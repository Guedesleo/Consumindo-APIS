defmodule ReposFindWeb.RepositoriesController do
  use ReposFindWeb, :controller

  alias ReposFindWeb.Auth.Guardian
  alias ReposFindWeb.FallbackController

  action_fallback FallbackController

  def index(connection, _params) do
    with user <- Guardian.Plug.current_resource(connection),
         {:ok, repositories} <-
           ReposFind.get_all_repositories(user.username) do
      connection
      |> put_status(:ok)
      |> render("index.json", user: user, repositories: repositories)
    end
  end

  def show(connection, %{"username" => username}) do
    with {:ok, [_ | _] = repositories} <- ReposFind.get_all_repositories(username) do
      connection
      |> put_status(:ok)
      |> render("show.json", repositories: repositories)
    end
  end
end
