# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :protocol_builder,
  ecto_repos: [ProtocolBuilder.Repo],
  basic_auth: [
    username: System.get_env("BASIC_AUTH_USERNAME"),
    password: System.get_env("BASIC_AUTH_PASSWORD"),
    realm: System.get_env("BASIC_AUTH_REALM")
  ],
  acme_challenge: System.get_env("ACME_CHALLENGES")

# config :acmex,
#   directory_url: "https://acme-staging-v02.api.letsencrypt.org/directory",
#   account_key_path:
#     [File.cwd!(), "./priv/acmex/account.key"]
#     |> Path.join()
#     |> Path.expand(),
#   account_email: "rgulans@gmail.com",
#   domains: ["example.com"],
#   certificate_path:
#     [File.cwd!(), "./priv/acmex/certificate.key"]
#     |> Path.join()
#     |> Path.expand()

# Configures the endpoint
config :protocol_builder, ProtocolBuilderWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "FgHxN2UQ34GxYgsmYsXSmV9nDA7MavjX8DrUxRZ2Jr7PDqHks3heB/ushHJSt5Qq",
  render_errors: [view: ProtocolBuilderWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: ProtocolBuilder.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [
    signing_salt: "RfYxnif0klxmuIBkkCTGhdilGnCGvUhn"
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
