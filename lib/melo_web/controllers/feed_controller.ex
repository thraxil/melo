defmodule MeloWeb.FeedController do
  use MeloWeb, :controller
  use Timex

  plug :put_layout, false

  def index(conn, _params) do
    images = Melo.Main.newest_images()
    [first | _] = images
    last_build_date = first.inserted_at

    conn
    |> put_resp_content_type("text/xml")
    |> send_resp(200, content(conn, images, last_build_date))
    |> halt()
  end

  defp content(conn, images, last_build_date) do
    # this obviously still needs a lot of work
    EEx.eval_string(
      """
      <rss version="2.0" xmlns:atom="http://www.w3.org/2005/Atom">
      <channel>
      <title>Pixelvore</title>
      <link><%= @link %></link>
      <description>Newest images from pixelvore.</description>
      <language>en</language>
      <lastBuildDate><%= @last_build_date %></lastBuildDate>
      </channel>
      </rss>
      """,
      assigns: [
        conn: conn,
        images: images,
        last_build_date: to_rfc822(last_build_date),
        link: Routes.page_path(conn, :index)
      ]
    )
  end

  defp to_rfc822(date) do
    date
    |> Timezone.convert("GMT")
    |> Timex.format!("{WDshort}, {D} {Mshort} {YYYY} {h24}:{m}:{s} {Zname}")
  end
end
