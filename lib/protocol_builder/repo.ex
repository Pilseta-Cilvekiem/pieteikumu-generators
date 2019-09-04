defmodule ProtocolBuilder.Repo do
  use Ecto.Repo,
    otp_app: :protocol_builder,
    adapter: Ecto.Adapters.Postgres
end
