defmodule ReposFind.Repositories.Get do
  alias ReposFind.Error

  def call(username) do
    with {:ok, repositories} <- client().get_repositories(username) do
      {:ok, repositories}
    else
      {:error, %Error{}} = error -> error
    end
  end

  defp client do
    :repos_find
    |> Application.fetch_env!(__MODULE__)
    |> Keyword.get(:github_repos_adapter)
  end
end
