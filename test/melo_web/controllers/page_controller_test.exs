defmodule MeloWeb.PageControllerTest do
  use MeloWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Pixelvore"
  end
end
