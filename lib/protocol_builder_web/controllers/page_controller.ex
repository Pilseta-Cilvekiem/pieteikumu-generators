defmodule ProtocolBuilderWeb.PageController do
  use ProtocolBuilderWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
