defmodule Osuuspuutarha.Season.Calendar do
  use Ecto.Schema
  import Ecto.Changeset

  schema "calendars" do
    field :is_picked_up, :boolean, default: false
    field :pickup_date, :date
    field :order_id, :id

    timestamps()
  end

  @doc false
  def changeset(calendar, attrs) do
    calendar
    |> cast(attrs, [:pickup_date, :is_picked_up])
    |> validate_required([:pickup_date, :is_picked_up])
  end
end
