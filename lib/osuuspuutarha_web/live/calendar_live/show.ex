defmodule OsuuspuutarhaWeb.CalendarLive.Show do
  use OsuuspuutarhaWeb, :live_view

  alias Osuuspuutarha.Season

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:calendar, Season.get_calendar!(id))}
  end

  defp page_title(:show), do: "Show Calendar"
  defp page_title(:edit), do: "Edit Calendar"
end
