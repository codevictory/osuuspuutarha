defmodule OsuuspuutarhaWeb.YieldLive.Index do
  use OsuuspuutarhaWeb, :live_view

  alias Osuuspuutarha.Harvest
  alias Osuuspuutarha.Harvest.Yield

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :yields, list_yields())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit yield")
    |> assign(:yield, Harvest.get_yield!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New yield")
    |> assign(:yield, %Yield{unit: :kg, date: DateTime.utc_now()})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Good day, Albert!")
    |> assign(:yield, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    yield = Harvest.get_yield!(id)
    {:ok, _} = Harvest.delete_yield(yield)

    {:noreply, assign(socket, :yields, list_yields())}
  end

  defp list_yields do
    Harvest.list_yields()
  end
end
