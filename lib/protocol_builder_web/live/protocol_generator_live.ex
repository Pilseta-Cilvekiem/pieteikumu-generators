defmodule ProtocolBuilderWeb.ProtocolGeneratorLive do
  use Phoenix.LiveView
  alias ProtocolBuilderWeb.ProtocolGeneratorView

  def render(assigns), do: ProtocolGeneratorView.render("index.html", assigns)

  def mount(_, socket) do
    now = Timex.now("Europe/Riga")

    {:ok, date} = Timex.format(now, "%Y gada %d. %B", :strftime)
    {:ok, time} = Timex.format(now, "%H:%M", :strftime)
    date = prepare_month(date)

    start_values = %{
      "infringement_date" => date,
      "infringement_time" => time,
      "protocol_date" => date
    }

    socket =
      socket
      |> assign(:protocol, "unauthorized-parking.html")
      |> assign_values(start_values)

    {:ok, socket}
  end

  def handle_event("rerender", input, socket) do
    {:noreply, assign_values(socket, input)}
  end

  defp assign_values(socket, values) do
    socket
    |> assign(:person_name, Map.get(values, "person_name", ""))
    |> assign(:person_code, Map.get(values, "person_code", ""))
    |> assign(:person_address, Map.get(values, "person_address", ""))
    |> assign(:person_phone, Map.get(values, "person_phone", ""))
    |> assign(:infringement_date, Map.get(values, "infringement_date", ""))
    |> assign(:infringement_time, Map.get(values, "infringement_time", ""))
    |> assign(:infringement_address, Map.get(values, "infringement_address", ""))
    |> assign(:infringement_car_mark, Map.get(values, "infringement_car_mark", ""))
    |> assign(:infringement_car_number, Map.get(values, "infringement_car_number", ""))
    |> assign(:protocol_date, Map.get(values, "protocol_date", ""))
  end

  defp prepare_month(date) do
    date
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
end
