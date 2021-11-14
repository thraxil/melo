defmodule Melo.Main.Image do
  use Ecto.Schema
  import Ecto.Changeset

  schema "images" do
    field :ahash, :string
    field :ext, :string
    field :url, :string

    many_to_many :tags, Melo.Main.Tag, join_through: "image_tags"

    timestamps()
  end

  @doc false
  def changeset(image, attrs) do
    image
    |> cast(attrs, [:url, :ahash, :ext])
    |> validate_required([:url, :ahash, :ext])
  end
end
