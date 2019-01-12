# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :generix_inv,
  ecto_repos: [GenerixInv.Repo]

# Configures the endpoint
config :generix_inv, GenerixInvWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "PcECar93zBxDeZZXM2Apr+WICNrxeT06saHKdz/f6vq6p+hHj+YkxERAgHJm2Kqh",
  render_errors: [view: GenerixInvWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: GenerixInv.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
