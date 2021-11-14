defmodule Melo.Repo.Migrations.CreateImages do
  use Ecto.Migration

  def change do
    create table(:images) do
      add :url, :string
      add :ahash, :string
      add :ext, :string

      timestamps()
    end
  end
end
