defmodule ReposFind.Users.Get do
  alias ReposFind.{Error, Repo, User}

  def by_id(id) do
    case Repo.get(User, id) do
      nil -> {:error, Error.build_user_not_found_error()}
      user -> {:ok, user}
    end
  end

  def by_username(username) do
    case Repo.get_by(User, username: username) do
      nil -> {:error, Error.build_user_not_found_error()}
      user -> {:ok, user}
    end
  end

  def all() do
    users =
      Repo.all(User)
      |> get_all_users(%{}, 0)

    {:ok, users}
  end

  defp get_all_users([%User{} = user | tail], acc, id_acc) do
    acc = Map.put_new(acc, id_acc, user)

    id_acc = id_acc + 1
    get_all_users(tail, acc, id_acc)
  end

  defp get_all_users([], acc, _id_acc), do: acc
end
