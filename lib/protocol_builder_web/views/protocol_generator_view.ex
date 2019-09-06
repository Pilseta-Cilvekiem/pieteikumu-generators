defmodule ProtocolBuilderWeb.ProtocolGeneratorView do
  use ProtocolBuilderWeb, :view

  def highlight_empty_value(assigns, type) do
    case assigns[type] do
      value when value in [nil, ""] -> "<mark>#{default_value(type)}</mark>"
      value -> value
    end
  end

  def default_value(:person_name), do: "Janis Berziņš"
  def default_value(:person_code), do: "000000-00000"
  def default_value(:person_address), do: "Brīvības iela 1 - 1"
  def default_value(:person_phone), do: "+371 11111111"
  def default_value(:infringement_date), do: "2000 gada 1. janvārī"
  def default_value(:infringement_time), do: "00:00"
  def default_value(:infringement_address), do: "Brīvības iela 1"
  def default_value(:infringement_car_mark), do: "Teslu"
  def default_value(:infringement_car_number), do: "LV-0000"
  def default_value(:protocol_date), do: "2000 gada 1. janvārī"
end
