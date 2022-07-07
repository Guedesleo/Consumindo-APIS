defmodule ReposFind.Github.ClientTest do
  use ExUnit.Case, async: true

  import ReposFind.Factory

  alias ReposFind.Error
  alias ReposFind.Github.Client

  describe "get_repositories/1" do
    setup do
      bypass = Bypass.open()

      {:ok, bypass: bypass}
    end

    test "when there is a valid username, returns the repositories info", %{bypass: bypass} do
      username = "abcdf123"

      url = endpoint_url(bypass.port)

      body =
        Jason.encode!([
          %{
            created_at: "2016-12-20T16:25:28",
            description: nil,
            html_url: "https://github.com/abcdf123/jn",
            id: 76_972_604,
            language: nil,
            name: "jn",
            stargazers_count: 0
          }
        ])

      Bypass.expect(bypass, "GET", "#{username}/repos", fn conn ->
        conn
        |> Plug.Conn.put_resp_header("content-type", "application/json")
        |> Plug.Conn.resp(200, body)
      end)

      response = Client.get_repositories(url, username)

      expected_response = {:ok, [build(:repositories)]}

      assert response == expected_response
    end

    test "when username is unknown, returns an error", %{bypass: bypass} do
      username = "abcdf123789"

      url = endpoint_url(bypass.port)

      Bypass.expect(bypass, "GET", "#{username}/repos", fn conn ->
        conn
        |> Plug.Conn.put_resp_header("content-type", "application/json")
        |> Plug.Conn.resp(404, "")
      end)

      response = Client.get_repositories(url, username)

      expected_response = {
        :error,
        %Error{result: "Page not found!", status: :not_found}
      }

      assert response == expected_response
    end

    test "when there is a generic error, returns an error", %{bypass: bypass} do
      username = "username"

      url = endpoint_url(bypass.port)

      Bypass.down(bypass)

      response = Client.get_repositories(url, username)

      expected_response =
        {:error,
         %Error{
           result: :econnrefused,
           status: :bad_request
         }}

      assert response == expected_response
    end

    defp endpoint_url(port), do: "http://localhost:#{port}"
  end
end
