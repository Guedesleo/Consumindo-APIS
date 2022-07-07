defmodule ReposFindWeb.RepositoriesViewTest do
  use ReposFindWeb.ConnCase, async: true

  import Phoenix.View
  import ReposFind.Factory

  alias ReposFindWeb.RepositoriesView

  describe "render/2" do
    test "renders show.json" do
      repositories = build(:repositories)

      response = render(RepositoriesView, "show.json", repositories: repositories)

      assert %{
               repositories: %{
                 created_at: ~N[2016-12-20 16:25:28],
                 description: nil,
                 html_url: "https://github.com/abcdf123/jn",
                 id: 76_972_604,
                 language: nil,
                 name: "jn",
                 stargazers_count: 0
               }
             } = response
    end
  end
end
