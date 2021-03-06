defmodule LRTF.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :username, :string
      add :avatar, :string

      timestamps()
    end
    create unique_index(:users, [:username])

  end
end
