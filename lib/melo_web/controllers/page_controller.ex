defmodule MeloWeb.PageController do
  use MeloWeb, :controller

  def index(conn, _params) do
    images = Melo.Main.newest_images()
    render conn, "index.html", images: images
  end
end
