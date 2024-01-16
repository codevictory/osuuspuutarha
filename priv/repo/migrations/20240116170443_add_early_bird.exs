defmodule Osuuspuutarha.Repo.Migrations.AddEarlyBird do
  use Ecto.Migration

  def change do
    alter table(:orders) do
      add :early_bird, :boolean, default: false, null: false
    end
  end
end
