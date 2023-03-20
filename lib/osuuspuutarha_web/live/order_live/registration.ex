defmodule OsuuspuutarhaWeb.OrderLive.Registration do
  use OsuuspuutarhaWeb, :live_view

  alias Osuuspuutarha.Orders.Order

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(_, _, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action)}
  end

  defp apply_action(socket, :index) do
    socket
    |> assign(:page_title, "Tilaukset")
    |> assign(:order, nil)
  end

  defp apply_action(socket, :new) do
    socket
    |> assign(:page_title, "Satolaatikkotilaus")
    |> assign(:order, %Order{})
  end
end
