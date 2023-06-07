defmodule OsuuspuutarhaWeb.CalendarLive.FormComponent do
  use OsuuspuutarhaWeb, :live_component

  alias Osuuspuutarha.Season

  @impl true
  def update(%{calendar: calendar} = assigns, socket) do
    changeset = Season.change_calendar(calendar)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"calendar" => calendar_params}, socket) do
    changeset =
      socket.assigns.calendar
      |> Season.change_calendar(calendar_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"calendar" => calendar_params}, socket) do
    save_calendar(socket, socket.assigns.action, calendar_params)
  end

  defp save_calendar(socket, :edit, calendar_params) do
    case Season.update_calendar(socket.assigns.calendar, calendar_params) do
      {:ok, _calendar} ->
        {:noreply,
         socket
         |> put_flash(:info, "Calendar updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_calendar(socket, :new, calendar_params) do
    case Season.create_calendar(calendar_params) do
      {:ok, _calendar} ->
        {:noreply,
         socket
         |> put_flash(:info, "Calendar created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
