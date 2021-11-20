defmodule MeloWeb.PageController do
  use MeloWeb, :controller

  def index(conn, _params) do
    defaults = %{ "page" => "1" }
    params = Map.merge(defaults, conn.query_params)
    {page, _} = Integer.parse(params["page"])
    images_count = Melo.Main.count_images()
    max_page = (div images_count, 20) + 1
    images = Melo.Main.newest_images(min(page, max_page))
    has_next = (page * 20) <= images_count
    current_user = get_session(conn, :current_user)
    render conn, "index.html",
      images: images,
      page: min(page, max_page),
      prev_page: max(page - 1, 1),
      has_prev: page > 1,
      next_page: page + 1,
      has_next: has_next,
      current_user: current_user
  end

  def image(conn, %{"id" => id}) do
    image = Melo.Main.get_image!(id)
    render conn, "image.html", image: image, current_user: get_session(conn, :current_user)
  end

  def tag(conn, %{"slug" => slug}) do
    tag = Melo.Main.get_tag!(slug)
    render conn, "tag.html", tag: tag, current_user: get_session(conn, :current_user)
  end

  def tags(conn, _params) do
    tags = Melo.Main.all_tags()
    render conn, "tags.html", tags: tags, current_user: get_session(conn, :current_user)
  end

  def random(conn, _params) do
    image = Melo.Main.get_random_image!()
    render conn, "image.html", image: image, current_user: get_session(conn, :current_user)
  end
end
