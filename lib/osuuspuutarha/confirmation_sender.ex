defmodule Osuuspuutarha.ConfirmationSender do
  @moduledoc """
  This module is responsible for sending confirmation emails.
  """
  import Swoosh.Email
  alias Osuuspuutarha.Orders.Parser

  def send_confirmation_email(order) do
    new()
    |> to({"#{order.fname} #{order.lname}", order.email})
    |> from({"Livonsaaren Osuuspuutarha", "noreply@livonsaarenosuuspuutarha.fi"})
    |> subject("Tilauksesi on vastaanotettu")
    |> html_body("<h1>Kiitokset satolaatikkotilauksestasi, #{order.fname}!</h1>
<h2>Tiedot</h2>
<ul>
<li>Tilausmuoto: <b>#{Parser.parse_order_type(order.order_type)}</b></li>
<li>Jakopaikka: <b>#{Parser.parse_location_long(order.location)}</b></li>
<li>Uusi jäsen: <b>#{Parser.parse_boolean(!order.is_member)}</b></li>
<li>Lasku kahdessa erässä: <b>#{Parser.parse_boolean(order.split_invoice)}</b></li>
</ul>
<p>Terveisin,<br/>
<b>Livonsaaren Osuuspuutarha</b></p>")
    |> text_body("Kiitokset satolaatikkotilauksestasi, #{order.fname}!\n
\n
Tiedot:\n
Tilausmuoto: #{Parser.parse_order_type(order.order_type)}\n
Jakopaikka: #{Parser.parse_location_long(order.location)}\n
Uusi jäsen: #{Parser.parse_boolean(!order.is_member)}\n
Lasku kahdessa erässä: #{Parser.parse_boolean(order.split_invoice)}\n
\n
Terveisin,\n
Livonsaaren Osuuspuutarha")
  end
end
