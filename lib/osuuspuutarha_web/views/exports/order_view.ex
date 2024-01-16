defmodule OsuuspuutarhaWeb.Exports.OrderView do
  use OsuuspuutarhaWeb, :view

  alias Elixlsx.{Workbook, Sheet}
  alias Osuuspuutarha.Orders.Parser

  @header [
    "Etunimi",
    "Sukunimi",
    "Katuosoite",
    "Paikkakunta",
    "Postinumero",
    "Sähköposti",
    "Puhelin",
    "Jäsen",
    "Tilaustyyppi",
    "Jakopaikka",
    "Parilliset viikot",
    "Jaettu lasku",
    "Lisätty",
    "Päivitetty"
  ]

  def render("tilaukset.xlsx", %{orders: orders}) do
    report_generator(orders)
    |> Elixlsx.write_to_memory("tilaukset.xlsx")
    |> elem(1)
    |> elem(1)
  end

  def report_generator(orders) do
    rows = orders |> Enum.map(&row(&1))
    %Workbook{sheets: [%Sheet{name: "Orders", rows: [@header] ++ rows}]}
  end

  def row(order) do
    [
      order.fname,
      order.lname,
      order.address,
      order.city,
      order.pcode,
      order.email,
      order.phone,
      Parser.parse_boolean(order.is_member),
      Parser.parse_order_type(order.order_type),
      Parser.parse_location(order.location),
      Parser.parse_boolean(order.even_weeks),
      Parser.parse_boolean(order.split_invoice),
      Parser.parse_boolean(order.early_bird),
      Parser.parse_date(order.inserted_at),
      Parser.parse_date(order.updated_at)
    ]
  end
end
