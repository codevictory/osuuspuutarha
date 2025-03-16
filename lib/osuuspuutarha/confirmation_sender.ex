defmodule Osuuspuutarha.ConfirmationSender do
  @moduledoc """
  This module is responsible for sending confirmation emails.
  """
  import Swoosh.Email

  def send_confirmation_email(order) do
    new()
    |> to({"Testi Testinen", "livonsaaren.tietokonepaja@gmail.com"})
    |> from({"Livonsaaren Osuuspuutarha", "noreply@livonsaarenosuuspuutarha.fi"})
    |> subject("Kiitokset tilauksesta!")
    |> html_body("<h1>Hello #{order.fname}</h1>")
    |> text_body("Hello #{order.fname}\n")
  end
end
