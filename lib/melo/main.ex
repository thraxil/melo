defmodule Melo.Main do
  import Ecto.Query, warn: false
  alias Melo.Repo
  alias Melo.Main.{Image,Tag}

  def newest_images() do
    q = from i in Image,
      where: i.ahash != "",
      order_by: [desc: :inserted_at],
      limit: 20
    Repo.all(q)
  end
end
