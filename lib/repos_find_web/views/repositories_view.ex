defmodule ReposFindWeb.RepositoriesView do
  use ReposFindWeb, :view

  def render("show.json", %{repositories: repositories}),
    do: %{
      repositories: repositories
    }

  def render("index.json", %{user: user, repositories: repositories}),
    do: %{
      user: user,
      repositories: repositories
    }
end
