defmodule OsuuspuutarhaWeb.YieldLive.Show do
  use OsuuspuutarhaWeb, :live_view

  alias Osuuspuutarha.Harvest

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:yield, Harvest.get_yield!(id))}
  end

  defp page_title(:show), do: "Show Yield"
  defp page_title(:edit), do: "Edit Yield"
end
