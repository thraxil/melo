defmodule Melo.Repo.Migrations.CreateTags do
  use Ecto.Migration

  def change do
    create table(:tags) do
      add :slug, :string
      add :tag, :string

      timestamps()
    end
  end
end
