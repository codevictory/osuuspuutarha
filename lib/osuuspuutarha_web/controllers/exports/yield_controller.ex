defmodule OsuuspuutarhaWeb.Exports.YieldController do
  use OsuuspuutarhaWeb, :controller

  alias Osuuspuutarha.Harvest

  def index(conn, _params) do
    yields = Harvest.list_yields()

    conn
    |> put_resp_content_type("text/xlsx")
    |> put_resp_header("content-disposition", "attachment; filename=\"korjuut.xlsx\"")
    |> render("korjuut.xlsx", %{yields: yields})
  end
end
