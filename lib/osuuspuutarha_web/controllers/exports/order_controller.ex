defmodule OsuuspuutarhaWeb.Exports.OrderController do
  use OsuuspuutarhaWeb, :controller

  alias Osuuspuutarha.Orders

  def index(conn, _params) do
    orders = Orders.list_orders()

    conn
    |> put_resp_content_type("text/xlsx")
    |> put_resp_header("content-disposition", "attachment; filename=\"tilaukset.xlsx\"")
    |> render("tilaukset.xlsx", %{orders: orders})
  end
end
