defmodule ReposFind.User do
  use Ecto.Schema

  import Ecto.Changeset

  alias Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}

  @required_params [:name, :password, :username]

  @update_required_params @required_params -- [:password]

  @derive {Jason.Encoder, only: @update_required_params ++ [:id]}

  # %Rockelivery.User{}
  schema "users" do
    field :name, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    field :username, :string

    timestamps()
  end

  def changeset(params) do
    %__MODULE__{}
    |> changeset_validation(params, @required_params)
  end

  def changeset(struct, params) do
    struct
    |> changeset_validation(params, @update_required_params)
  end

  defp changeset_validation(struct, params, required) do
    struct
    |> cast(params, required)
    |> validate_required(required)
    |> validate_length(:password, min: 6)
    |> validate_length(:username, min: 5)
    |> unique_constraint([:username])
    |> put_password_hash()
  end

  defp put_password_hash(%Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, Pbkdf2.add_hash(password))
  end

  defp put_password_hash(changeset), do: changeset
end
