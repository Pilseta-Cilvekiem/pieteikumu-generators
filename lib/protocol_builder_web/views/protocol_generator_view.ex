defmodule ProtocolBuilderWeb.ProtocolGeneratorView do
  use ProtocolBuilderWeb, :view

  def highlight_empty_value(assigns, type) do
    case assigns[type] do
      value when value in [nil, ""] -> "<mark>#{default_value(type)}</mark>"
      value -> prepare_value(value, type)
    end
  end

  def protocol_types() do
    %{
      "car-on-sidewalk" => "Automašīna novietota uz ietves",
      "car-in-green-zone" => "Automašīna novietota zaļajā zonā",
      "car-in-bike-path" => "Automašīna novietota uz velojoslas"
    }
  end

  def default_value(:person_name), do: "Janis Berziņš"
  def default_value(:person_code), do: "000000-00000"
  def default_value(:person_address), do: "Brīvības iela 1 - 1"
  def default_value(:person_phone), do: "+371 11111111"
  def default_value(:infringement_date), do: "2000 gada 1. janvārī"
  def default_value(:infringement_time), do: "00:00"
  def default_value(:infringement_address), do: "Brīvības iela 1"
  def default_value(:infringement_car_number), do: "LV-0000"
  def default_value(:protocol_date), do: "2000 gada 1. janvārī"
  def default_value(:protocol_type), do: "unauthorized-parking"

  defp prepare_value(date, type) when type in [:infringement_date, :protocol_date] do
    date
    |> Timex.parse!("%Y-%m-%d", :strftime)
    |> Timex.format!("%Y. gada %d. %B", :strftime)
    |> String.replace("April", "Aprīlī")
    |> String.replace("August", "Augustā")
    |> String.replace("December", "Decembrī")
    |> String.replace("February", "Februārī")
    |> String.replace("January", "Janvārī")
    |> String.replace("July", "Jūlijā")
    |> String.replace("June", "Jūnijā")
    |> String.replace("March", "Martā")
    |> String.replace("May", "Maijā")
    |> String.replace("November", "Novembrī")
    |> String.replace("October", "Oktobrī")
    |> String.replace("September", "Septembrī")
  end

  defp prepare_value(value, _type), do: value
end
