defmodule Melo.Main.ImageTag do
  use Ecto.Schema
  import Ecto.Changeset

  schema "image_tags" do
    field :image_id, :id
    field :tag_id, :id
  end

  @doc false
  def changeset(image_tag, attrs) do
    image_tag
    |> cast(attrs, [])
    |> validate_required([])
  end
end
