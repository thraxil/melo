defmodule Melo.Repo do
  use Ecto.Repo,
    otp_app: :melo,
    adapter: Ecto.Adapters.Postgres
end
