defmodule Melo.Repo.Migrations.RemoveNullAhashes do
  use Ecto.Migration
  import Ecto.Query, warn: false
  alias Melo.Repo
  alias Melo.Main.Image

  def change do
    # first delete the associations
    from(i in Image, where: i.ahash == "")
    |> Repo.all()
    |> Enum.each(fn image ->
      Repo.delete_all(from r in "image_tags", where: r.image_id == ^image.id, select: [r.id, r.image_id, r.tag_id])
    end)
    # then the images themselves
    from(i in Image, where: i.ahash == "") |> Repo.delete_all
  end
end
