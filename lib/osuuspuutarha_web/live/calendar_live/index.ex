defmodule OsuuspuutarhaWeb.CalendarLive.Index do
  use OsuuspuutarhaWeb, :live_view

  alias Osuuspuutarha.Season
  alias Osuuspuutarha.Season.Calendar

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :calendars, list_calendars())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Calendar")
    |> assign(:calendar, Season.get_calendar!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Calendar")
    |> assign(:calendar, %Calendar{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Calendars")
    |> assign(:calendar, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    calendar = Season.get_calendar!(id)
    {:ok, _} = Season.delete_calendar(calendar)

    {:noreply, assign(socket, :calendars, list_calendars())}
  end

  defp list_calendars do
    Season.list_calendars()
  end
end
