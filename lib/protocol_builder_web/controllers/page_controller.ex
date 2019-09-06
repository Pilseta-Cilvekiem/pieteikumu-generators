defmodule ProtocolBuilderWeb.PageController do
  use ProtocolBuilderWeb, :controller

  alias ProtocolBuilderWeb.ProtocolGeneratorLive

  plug BasicAuth, use_config: {:protocol_builder, :basic_auth}

  def index(conn, _params) do
    live_render(conn, ProtocolGeneratorLive, session: %{})
  end
end
