defmodule ReposFindWeb.UsersView do
  use ReposFindWeb, :view

  alias ReposFind.User

  def render("create.json", %{token: token, user: %User{} = user}) do
    %{
      message: "User created!",
      token: token,
      user: user
    }
  end

  def render("sign_in.json", %{token: token}),
    do: %{
      token: token
    }

  def render("sign_out.json", %{token: token, claims: claims}),
    do: %{
      message: "Logged Out Successfully!",
      token: token,
      claims: claims
    }

  def render("current_token.json", %{token: token, claims: claims}),
    do: %{
      token: token,
      claims: claims
    }

  def render("user.json", %{token: token, user: %User{} = user}),
    do: %{
      token: token,
      user: user
    }

  def render("index.json", %{token: token, users: users}),
    do: %{
      token: token,
      users: users
    }
end
