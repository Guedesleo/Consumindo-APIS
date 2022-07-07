defmodule ReposFind.Github.Behaviour do
  alias ReposFind.Error

  @typep client_result :: {:ok, list()} | {:error, Error.t()}

  @callback get_repositories(String.t()) :: client_result
end
