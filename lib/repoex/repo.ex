defmodule Repoex.Repo do
  use Ecto.Repo,
    otp_app: :repoex,
    adapter: Ecto.Adapters.Postgres
end
