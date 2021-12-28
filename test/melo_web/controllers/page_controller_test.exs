defmodule MeloWeb.PageControllerTest do
  use MeloWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Pixelvore"
  end

  test "GET /random", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Pixelvore"
  end

  test "admin needs login", %{conn: conn} do
    conn = get(conn, "/admin")
    assert redirected_to(conn) == "/auth/auth0"
  end

  test "GET an image", %{conn: conn} do
    image = Melo.MainFixtures.insert_image()
    conn = get(conn, "/image/" <> to_string(image.id))
    assert html_response(conn, 200) =~ image.ahash
  end

  test "inserted image should show up on index", %{conn: conn} do
    image = Melo.MainFixtures.insert_image()
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ image.ahash
    assert html_response(conn, 200) =~ to_string(image.id)
  end
end
