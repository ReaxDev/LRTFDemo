defmodule LRTF.Repo.Migrations.AddTwitterAuthFieldsToUser do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :twitter_secret, :string
      add :twitter_token, :string
    end
  end
end
