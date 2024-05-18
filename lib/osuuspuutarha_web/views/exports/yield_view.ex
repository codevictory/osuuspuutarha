defmodule OsuuspuutarhaWeb.Exports.YieldView do
  use OsuuspuutarhaWeb, :view

  alias Elixlsx.{Workbook, Sheet}
  alias Osuuspuutarha.Harvest.Parser

  @header [
    "Määrä",
    "Päivämäärä",
    "Kasvi",
    "Yksikkö"
  ]

  def render("korjuut.xlsx", %{yields: yields}) do
    report_generator(yields)
    |> Elixlsx.write_to_memory("korjuut.xlsx")
    |> elem(1)
    |> elem(1)
  end

  def report_generator(yields) do
    rows = yields |> Enum.map(&row(&1))
    %Workbook{sheets: [%Sheet{name: "Korjuut", rows: [@header] ++ rows}]}
  end

  def row(yield) do
    [
      Decimal.to_string(yield.amount),
      Parser.parse_date(yield.date),
      Parser.parse_plant(yield.plant),
      Parser.parse_unit(yield.unit)
    ]
  end
end
