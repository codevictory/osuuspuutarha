defmodule Osuuspuutarha.Repo do
  use Ecto.Repo,
    otp_app: :osuuspuutarha,
    adapter: Ecto.Adapters.Postgres
end
