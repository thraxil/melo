defmodule Melo.Main do
  import Ecto.Query, warn: false
  alias Melo.Repo
  alias Melo.Main.{Image,Tag}

  def newest_images(page \\ 1) do
    q = from i in Image,
      where: i.ahash != "",
      order_by: [desc: :inserted_at],
      limit: 20,
      offset: ^((page - 1) * 20)
    Repo.all(q)
  end

  def count_images() do
    q = from i in Image,
      where: i.ahash != ""
    Repo.aggregate(q, :count, :id)
  end

  def get_image!(id) do
    Repo.get!(Image, id) |> Repo.preload(:tags)
  end

  def get_random_image!() do
    count = count_images()
    idx = Enum.random(0..count)
    q = from i in Image,
      where: i.ahash != "",
      offset: ^idx,
      limit: 1
    Repo.one!(q) |> Repo.preload(:tags)
  end

  def get_tag!(slug) do
    Repo.get_by!(Tag, slug: slug) |> Repo.preload(:images)
  end

  def all_tags() do
    q = from t in Tag,
      order_by: t.tag
    Repo.all(q)
  end
end
