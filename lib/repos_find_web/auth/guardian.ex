defmodule ReposFindWeb.Auth.Guardian do
  use Guardian, otp_app: :repos_find

  alias ReposFind.{Error, User}
  alias ReposFind.Users.Get, as: UserGet

  def subject_for_token(%User{id: id}, _claims), do: {:ok, id}

  def resource_from_claims(%{"sub" => id}), do: UserGet.by_id(id)

  def authenticate(%{"username" => username, "password" => password}) do
    with {:ok, %User{password_hash: password_hash} = user} <- UserGet.by_username(username),
         true <- Pbkdf2.verify_pass(password, password_hash),
         {:ok, token, _claims} <-
           encode_and_sign(user, %{}, ttl: {1, :minute}) do
      {:ok, token}
    else
      false -> {:error, Error.build(:unauthorized, "Please verify your credentials!")}
      error -> error
    end
  end

  def authenticate(_), do: {:error, Error.build(:bad_request, "Invalid or missing parameters!")}
end
