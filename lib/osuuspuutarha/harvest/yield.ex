defmodule Osuuspuutarha.Harvest.Yield do
  use Ecto.Schema
  import Ecto.Changeset

  schema "yields" do
    field :amount, :decimal
    field :date, :date

    field :plant, Ecto.Enum,
      values: [
        :lettuce,
        :tomato,
        :cabbage,
        :white_cabbage,
        :red_cabbage,
        :pumpkin,
        :zucchini,
        :cucumber,
        :melon,
        :sweet_corn,
        :bean,
        :parsnip,
        :carrot,
        :beetroot,
        :rhubarb,
        :kale,
        :cauliflower,
        :broccoli,
        :portulak,
        :green_onions
      ]

    field :unit, Ecto.Enum, values: [:kg, :kpl]

    timestamps()
  end

  @doc false
  def changeset(yield, attrs) do
    yield
    |> cast(attrs, [:date, :plant, :amount, :unit])
    |> validate_required([:date, :plant, :amount, :unit])
  end
end
