defmodule ReposFindWeb.Auth.AuthTokens do
  use Guardian, otp_app: :repos_find

  alias ReposFind.{Error, User}
  alias ReposFind.Users.Get, as: UserGet

  def subject_for_token(%User{id: id}, _claims) do
    {:ok, "User:#{id}"}
  end

  def subject_for_token(_, _), do: {:error, :unhandled_resource_type}

  def resource_from_claims(%{"sub" => "User:" <> id}) do
    case UserGet.by_id(id) do
      nil -> Error.build_user_not_found_error()
      user -> {:ok, user}
    end
  end

  def resource_from_claims(_), do: {:error, :unhandled_resource_type}

  def after_encode_and_sign(resource, claims, token, _options) do
    IO.puts("after_encode_and_sign ::::::::::::::::::::")

    with {:ok, _} <- Guardian.DB.after_encode_and_sign(resource, claims["typ"], claims, token) do
      {:ok, token}
    end
  end

  def on_verify(claims, token, _options) do
    IO.puts("on_verify ::::::::::::::::::::")

    with {:ok, _} <- Guardian.DB.on_verify(claims, token) do
      {:ok, claims}
    end
  end

  def on_refresh({old_token, old_claims}, {new_token, new_claims}, _options) do
    IO.puts("on_refresh ::::::::::::::::::::")

    with {:ok, _, _} <- Guardian.DB.on_refresh({old_token, old_claims}, {new_token, new_claims}) do
      {:ok, {old_token, old_claims}, {new_token, new_claims}}
    end
  end

  def on_revoke(claims, token, _options) do
    IO.puts("on_revoke ::::::::::::::::::::")

    with {:ok, _} <- Guardian.DB.on_revoke(claims, token) do
      {:ok, claims}
    end
  end
end
