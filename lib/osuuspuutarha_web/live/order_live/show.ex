defmodule OsuuspuutarhaWeb.OrderLive.Show do
  use OsuuspuutarhaWeb, :live_view

  alias Osuuspuutarha.Orders

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:order, Orders.get_order!(id))}
  end

  defp page_title(:show), do: "Tilaukset tiedot"
  defp page_title(:edit), do: "Muokkaa tilausta"
end
