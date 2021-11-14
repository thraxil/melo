defmodule MeloWeb.PageController do
  use MeloWeb, :controller

  def index(conn, _params) do
    defaults = %{ "page" => "1" }
    params = Map.merge(defaults, conn.query_params)
    IO.inspect(params)
    {page, _} = Integer.parse(params["page"])
    images_count = Melo.Main.count_images()
    max_page = (div images_count, 20) + 1
    images = Melo.Main.newest_images(min(page, max_page))
    has_next = (page * 20) <= images_count
    render conn, "index.html",
      images: images,
      page: min(page, max_page),
      prev_page: max(page - 1, 1),
      has_prev: page > 1,
      next_page: page + 1,
      has_next: has_next
  end

  def image(conn, %{"id" => id}) do
    image = Melo.Main.get_image!(id)
    render conn, "image.html", image: image
  end

  def tag(conn, %{"slug" => slug}) do
  end
end
