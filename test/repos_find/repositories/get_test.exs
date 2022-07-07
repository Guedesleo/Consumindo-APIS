defmodule ReposFind.Repositories.GetTest do
  use ReposFind.DataCase, async: true

  import Mox
  import ReposFind.Factory

  alias ReposFind.Error
  alias ReposFind.Github.ClientMock
  alias ReposFind.Repositories.Get

  describe "call/1" do
    test "when all params are valid, returns the repositories" do
      params = "abcdf123"

      expect(ClientMock, :get_repositories, fn _username ->
        {:ok, build(:repositories)}
      end)

      response = Get.call(params)

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

    test "when there are invalid params, returns an error" do
      params = "abcdf123789"

      expect(ClientMock, :get_repositories, fn _username ->
        {:error, Error.build(:not_found, "Page not found!")}
      end)

      response = Get.call(params)

      assert {
               :error,
               %Error{result: "Page not found!", status: :not_found}
             } = response
    end
  end
end
