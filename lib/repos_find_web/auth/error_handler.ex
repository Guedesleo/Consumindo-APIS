defmodule ReposFindWeb.Auth.ErrorHandler do
  alias Guardian.Plug.ErrorHandler

  @behaviour ErrorHandler

  def auth_error(connection, {error, _reason}, _opts) do
    body = Jason.encode!(%{message: to_string(error)})

    connection
    |> Plug.Conn.put_resp_header("content-type", "application/json")
    |> Plug.Conn.send_resp(401, body)
  end
end
