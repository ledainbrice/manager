# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :manager,
  ecto_repos: [Manager.Repo]

# Configures the endpoint
config :manager, Manager.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "i17oBv0Jtkk6RGQ6lziS2KjT9CmyJ0Yc64uUloouzpK7QZCOSJ6M4wNIOQRFDwdk",
  render_errors: [view: Manager.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Manager.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Configure phoenix generators
config :phoenix, :generators,
  binary_id: true

# Configure secret for JWT
config :manager, Manager.JWT,
  secret: "a secret",
  expire: 3600

# Mailer configuration
config :manager, Manager.Mailer,
  adapter: Bamboo.MailgunAdapter
# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

import_config "config.secret.exs"

