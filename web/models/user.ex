defmodule LRTF.User do
  use LRTF.Web, :model

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
end
