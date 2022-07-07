defmodule ReposFindWeb.UsersController do
  use ReposFindWeb, :controller

  alias ReposFind.User
  alias ReposFindWeb.Auth.Guardian
  alias ReposFindWeb.FallbackController

  action_fallback FallbackController

  # params = %{name: "ABCDF123", password: "123456", username: "abcdf123"}
  # {:ok, %ReposFind.User{} = user} = ReposFind.create_user(params)
  # ReposFindWeb.Auth.Guardian.encode_and_sign(user)
  def create(connection, params) do
    with {:ok, %User{} = user} <- ReposFind.create_user(params),
         {:ok, token, _claims} <- Guardian.encode_and_sign(user) do
      connection
      |> put_status(:created)
      |> render("create.json", token: token, user: user)
    end
  end

  def update(connection, params) do
    with {:ok, %User{} = user} <- ReposFind.update_user(params),
         old_token <- Guardian.Plug.current_token(connection),
         {:ok, _old_stuff, {new_token, _new_claims}} <-
           Guardian.refresh(old_token, ttl: {1, :minute}) do
      connection
      |> put_status(:ok)
      |> render("user.json", token: new_token, user: user)
    end
  end

  def delete(connection, %{"id" => id}) do
    with {:ok, %User{}} <- ReposFind.delete_user(id),
         old_token <- Guardian.Plug.current_token(connection),
         {:ok, _old_stuff, {_new_token, _new_claims}} <-
           Guardian.refresh(old_token, ttl: {1, :minute}) do
      connection
      |> put_status(:no_content)
      |> text("")
    end
  end

  def index(connection, %{"username" => username}) do
    with {:ok, %User{} = user} <- ReposFind.get_user_by_username(username),
         old_token <- Guardian.Plug.current_token(connection),
         {:ok, _old_stuff, {new_token, _new_claims}} <-
           Guardian.refresh(old_token, ttl: {1, :minute}) do
      connection
      |> put_status(:ok)
      |> render("user.json", token: new_token, user: user)
    end
  end

  def index(connection, _params) do
    with {:ok, users} <- ReposFind.get_all_users(),
         old_token <- Guardian.Plug.current_token(connection),
         {:ok, _old_stuff, {new_token, _new_claims}} <-
           Guardian.refresh(old_token, ttl: {1, :minute}) do
      connection
      |> put_status(:ok)
      |> render("index.json", token: new_token, users: users)
    end
  end

  def show(connection, %{"id" => id}) do
    with {:ok, %User{} = user} <- ReposFind.get_user_by_id(id),
         old_token <- Guardian.Plug.current_token(connection),
         {:ok, _old_stuff, {new_token, _new_claims}} <-
           Guardian.refresh(old_token, ttl: {1, :minute}) do
      connection
      |> put_status(:ok)
      |> render("user.json", token: new_token, user: user)
    end
  end

  def sign_in(connection, params) do
    with {:ok, token} <- Guardian.authenticate(params) do
      connection
      |> put_status(:ok)
      |> render("sign_in.json", token: token)
    end
  end

  def sign_out(connection, _params) do
    with token <- Guardian.Plug.current_token(connection),
         {:ok, claims} = Guardian.revoke(token) do
      connection
      |> put_status(:ok)
      |> render("sign_out.json", token: token, claims: claims)
    end
  end

  def current_token(connection, _params) do
    with token <- Guardian.Plug.current_token(connection),
         {:ok, claims} <- Guardian.decode_and_verify(token) do
      connection
      |> render("current_token.json", token: token, claims: claims)
    end
  end
end
