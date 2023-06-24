defmodule Melo.Main.Tag do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tags" do
    field :slug, :string
    field :tag, :string

    many_to_many :images, Melo.Main.Image, join_through: "image_tags"

    timestamps()
  end

  @doc false
  def changeset(tag, attrs) do
    tag
    |> cast(attrs, [:slug, :tag])
    |> validate_required([:slug, :tag])
  end
end
