defmodule Melo.Repo.Migrations.CreateImageTags do
  use Ecto.Migration

  def change do
    create table(:image_tags) do
      add :image_id, references(:images, on_delete: :nothing)
      add :tag_id, references(:tags, on_delete: :nothing)
    end

    create index(:image_tags, [:image_id])
    create index(:image_tags, [:tag_id])
  end
end
