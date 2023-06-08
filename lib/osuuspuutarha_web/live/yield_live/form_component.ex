defmodule OsuuspuutarhaWeb.YieldLive.FormComponent do
  use OsuuspuutarhaWeb, :live_component

  alias Osuuspuutarha.Harvest

  @impl true
  def update(%{yield: yield} = assigns, socket) do
    changeset = Harvest.change_yield(yield)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"yield" => yield_params}, socket) do
    changeset =
      socket.assigns.yield
      |> Harvest.change_yield(yield_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"yield" => yield_params}, socket) do
    save_yield(socket, socket.assigns.action, yield_params)
  end

  defp save_yield(socket, :edit, yield_params) do
    case Harvest.update_yield(socket.assigns.yield, yield_params) do
      {:ok, _yield} ->
        {:noreply,
         socket
         |> put_flash(:info, "Yield updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_yield(socket, :new, yield_params) do
    case Harvest.create_yield(yield_params) do
      {:ok, _yield} ->
        {:noreply,
         socket
         |> put_flash(:info, "Yield created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
