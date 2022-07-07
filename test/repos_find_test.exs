defmodule ReposFindTest do
  use ReposFind.DataCase, async: true

  import Mox
  import ReposFind.Factory

  alias ReposFind.Github.ClientMock

  describe "get_all_repositories/1" do
    test "when all params are valid, returns the repositories" do
      params = %{"username" => "abcdf123"}

      expect(ClientMock, :get_repositories, fn _username ->
        {:ok, build(:repositories)}
      end)

      response = ReposFind.get_all_repositories(params)

      assert {:ok,
              %{
                created_at: ~N[2016-12-20 16:25:28],
                description: nil,
                html_url: "https://github.com/abcdf123/jn",
                id: 76_972_604,
                language: nil,
                name: "jn",
                stargazers_count: 0
              }} = response
    end
  end
end
