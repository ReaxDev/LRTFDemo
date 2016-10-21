defmodule LRTF.User do
  use LRTF.Web, :model
  alias Ueberauth.Auth
  alias LRTF.User

  schema "users" do
    field :username, :string
    field :avatar, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:username, :avatar])
    |> validate_required([:username, :avatar])
    |> unique_constraint(:username)
  end

  def find_or_create(%Auth{} = auth) do
    user = Repo.one(from u in User, where: u.username == ^auth.info.nickname) || %User{}
    user
    |> changeset(basic_info(auth))
    |> Repo.insert_or_update
  end

  defp basic_info(auth) do
    %{username: auth.info.nickname, avatar: auth.info.image}
  end
end

