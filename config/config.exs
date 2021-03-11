# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# Configures the endpoint
config :comment_graphql, CommentGraphqlWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "IixXnG0EP9sxfDe5EEWO6cCdIEUWaXJPn2qnmEIZP9aiiL3euetxTP/H1SqCevYc",
  render_errors: [view: CommentGraphqlWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: CommentGraphql.PubSub,
  live_view: [signing_salt: "79hc9nl2"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
