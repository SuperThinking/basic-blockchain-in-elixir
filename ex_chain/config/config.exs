# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# Configures the endpoint
config :ex_chain, ExChainWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "A6/ij8Gfcvx80iby++Oq1U7uDmqyX4ceXeSCl4XjcMMiGifnr3SFBfRBHRfWabG3",
  render_errors: [view: ExChainWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: ExChain.PubSub,
  live_view: [signing_salt: "oOFfyLTT"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
