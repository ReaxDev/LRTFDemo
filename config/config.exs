# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :lrtf,
  namespace: LRTF,
  ecto_repos: [LRTF.Repo]

# Configures the endpoint
config :lrtf, LRTF.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "YKfDJId5fLk+t802DLsigYPkPSvaLHehpaxlM9aAdPACM0sKl8vZjXS8G9GvY3wA",
  render_errors: [view: LRTF.ErrorView, accepts: ~w(html json)],
  pubsub: [name: LRTF.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :phoenix, :generators,
        migration: true,
        binary_id: true

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
