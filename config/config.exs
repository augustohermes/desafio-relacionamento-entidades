# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :repoex,
  ecto_repos: [Repoex.Repo]

config :repoex, Repoex.Repo,
  migration_primary_key: [type: :binary_id],
  migration_foreign_key: [type: :binary_id]

config :repoex, Repoex, get_repos_adapter: Repoex.GetRepos

config :repoex, RepoexWeb.Auth.Guardian,
  issuer: "repoex",
  secret_key: "RU23n26xeQu/RoI//mJ94weJ7bccJuOogqy068oBVgX1NPEUhU8PAKpryU+VGgP+"

config :repoex, RepoexWeb.Auth.Pipeline,
  module: RepoexWeb.Auth.Guardian,
  error_handler: RepoexWeb.Auth.ErrorHandler

# Configures the endpoint
config :repoex, RepoexWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "XgHdRZly0bgj2Kufu6Bhhr1mXiMaUCWh1rXQZDcZVMQYqwi77tCsmPOt+X4iD9dP",
  render_errors: [view: RepoexWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Repoex.PubSub,
  live_view: [signing_salt: "hfFi/UQB"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
