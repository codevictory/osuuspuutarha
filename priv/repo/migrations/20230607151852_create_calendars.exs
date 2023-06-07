defmodule Osuuspuutarha.Repo.Migrations.CreateCalendars do
  use Ecto.Migration

  def change do
    create table(:calendars) do
      add :pickup_date, :date
      add :is_picked_up, :boolean, default: false, null: false
      add :order_id, references(:orders, on_delete: :nothing)

      timestamps()
    end

    create index(:calendars, [:order_id])
  end
end
