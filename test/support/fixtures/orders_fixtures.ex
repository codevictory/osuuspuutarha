defmodule Osuuspuutarha.OrdersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Osuuspuutarha.Orders` context.
  """

  @doc """
  Generate a order.
  """
  def order_fixture(attrs \\ %{}) do
    {:ok, order} =
      attrs
      |> Enum.into(%{
        address: "some address",
        city: "some city",
        email: "some email",
        even_weeks: true,
        fname: "some fname",
        is_member: true,
        lname: "some lname",
        location: :koroinen,
        order_type: :full,
        pcode: "some pcode",
        phone: "some phone",
        split_invoice: true
      })
      |> Osuuspuutarha.Orders.create_order()

    order
  end
end
