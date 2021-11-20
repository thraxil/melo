defmodule MeloWeb.AuthController do
  use MeloWeb, :controller
  alias MeloWeb.Router.Helpers

  plug(Ueberauth)

  alias Ueberauth.Strategy.Helpers
  alias MeloWeb.UserFromAuth

  defp auth0_logout() do
    # TODO: implement this. needs to figure out correct logout url for returnTu
    "https:" <> System.get_env("AUTH0_DOMAIN") <> "/v2/logout?client_id=YOUR_CLIENT_ID&returnTo=LOGOUT_URL"
  end
  
  def logout(conn, _params) do
    conn
    |> put_flash(:info, "You have been logged out!")
    |> configure_session(drop: true)
#   |> redirect(to: auth0_logout())
    |> redirect(to: "/")
  end

  def callback(%{assigns: %{ueberauth_failure: _fails}} = conn, _params) do
    conn
    |> put_flash(:error, "Failed to authenticate.")
    |> redirect(to: "/")
  end

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, _params) do
    case UserFromAuth.find_or_create(auth) do
      {:ok, user} ->
        conn
        # |> put_flash(:info, "Successfully authenticated as " <> user.name <> ".")
        |> put_session(:current_user, user)
        |> redirect(to: "/admin")

      {:error, reason} ->
        conn
        |> put_flash(:error, reason)
        |> redirect(to: "/")
    end
  end
end
