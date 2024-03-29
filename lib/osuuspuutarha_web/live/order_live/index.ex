defmodule OsuuspuutarhaWeb.OrderLive.Index do
  use OsuuspuutarhaWeb, :live_view

  alias Osuuspuutarha.Orders
  alias Osuuspuutarha.Orders.Order

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :orders, Orders.get_sorted_by(:desc, :inserted_at))}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Muokkaa tilausta")
    |> assign(:submit_text, "Tallenna")
    |> assign(:order, Orders.get_order!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "Satolaatikkotilaus")
    |> assign(:submit_text, "Lähetä")
    |> assign(:order, %Order{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Tilaukset")
    |> assign(:order, nil)
  end

  defp apply_action(socket, :sorted_asc, %{"column" => column}) do
    socket
    |> assign(:page_title, "Tilaukset")
    |> assign(:orders, Orders.get_sorted_by(:asc, String.to_atom(column)))
    |> assign(:column, String.to_atom(column))
  end

  defp apply_action(socket, :sorted_desc, %{"column" => column}) do
    socket
    |> assign(:page_title, "Tilaukset")
    |> assign(:orders, Orders.get_sorted_by(:desc, String.to_atom(column)))
    |> assign(:column, String.to_atom(column))
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    order = Orders.get_order!(id)
    {:ok, _} = Orders.delete_order(order)

    {:noreply, assign(socket, :orders, Orders.list_orders())}
  end
end
