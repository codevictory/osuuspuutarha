defmodule Osuuspuutarha.Repo.Migrations.CreateYields do
  use Ecto.Migration

  def change do
    create table(:yields) do
      add :date, :date
      add :plant, :string
      add :amount, :decimal
      add :unit, :string

      timestamps()
    end
  end
end
