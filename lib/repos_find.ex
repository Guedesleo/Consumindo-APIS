defmodule ReposFind do
  alias ReposFind.Repositories.Get, as: RepositoryGet

  alias ReposFind.Users.Create, as: UserCreate
  alias ReposFind.Users.Delete, as: UserDelete
  alias ReposFind.Users.Get, as: UserGet
  alias ReposFind.Users.Update, as: UserUpdate

  defdelegate create_user(params), to: UserCreate, as: :call
  defdelegate delete_user(id), to: UserDelete, as: :call
  defdelegate get_all_users(), to: UserGet, as: :all
  defdelegate get_user_by_id(id), to: UserGet, as: :by_id
  defdelegate get_user_by_username(username), to: UserGet, as: :by_username
  defdelegate update_user(params), to: UserUpdate, as: :call

  defdelegate get_all_repositories(params), to: RepositoryGet, as: :call
end
