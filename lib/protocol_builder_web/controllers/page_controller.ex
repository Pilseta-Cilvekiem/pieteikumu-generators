defmodule ProtocolBuilderWeb.PageController do
  use ProtocolBuilderWeb, :controller

  alias ProtocolBuilderWeb.ProtocolGeneratorLive

  @options Application.fetch_env!(:protocol_builder, :basic_auth)

  if(@options[:username] != "" && @options[:password] != "") do
    plug BasicAuth, use_config: {:protocol_builder, :basic_auth}
  end

  def index(conn, _params) do
    live_render(conn, ProtocolGeneratorLive, session: %{})
  end

  # @acme_challenges_split " "
  # @acme_cahllenges_key_value_split ":"

  # def acme_challenge(conn, %{"token" => token}) do
  #   with value when not is_nil(value) <-
  #          Application.get_env(:protocol_builder, :acme_challenge),
  #        challenges <- String.split(value, @acme_challenges_split),
  #        cha when not is_nil(cha) <- Enum.find(challenges, &String.starts_with?(&1, token)),
  #        [^token, value] <- String.split(cha, @acme_cahllenges_key_value_split) do
  #     text(conn, value)
  #   else
  #     _ ->
  #       conn
  #       |> put_status(:not_found)
  #       |> put_view(ProtocolBuilderWeb.ErrorView)
  #       |> render("404.html")
  #   end
  # end
end
