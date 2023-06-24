defmodule MeloWeb.AdminController do
  use MeloWeb, :controller
  plug :secure

  defp secure(conn, _params) do
    user = get_session(conn, :current_user)

    case user do
      nil ->
        conn |> redirect(to: "/auth/auth0") |> halt

      _ ->
        conn
        |> assign(:current_user, user)
    end
  end

  def index(conn, _params) do
    current_user = get_session(conn, :current_user)
    IO.inspect(current_user)
    render(conn, "index.html", current_user: current_user)
  end
end
