defmodule MeloWeb.PageController do
  use MeloWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
