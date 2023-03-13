defmodule Osuuspuutarha.OrdersTest do
  use Osuuspuutarha.DataCase

  alias Osuuspuutarha.Orders

  describe "orders" do
    alias Osuuspuutarha.Orders.Order

    import Osuuspuutarha.OrdersFixtures

    @invalid_attrs %{address: nil, city: nil, email: nil, even_weeks: nil, fname: nil, is_member: nil, lname: nil, location: nil, order_type: nil, pcode: nil, phone: nil, split_invoice: nil}

    test "list_orders/0 returns all orders" do
      order = order_fixture()
      assert Orders.list_orders() == [order]
    end

    test "get_order!/1 returns the order with given id" do
      order = order_fixture()
      assert Orders.get_order!(order.id) == order
    end

    test "create_order/1 with valid data creates a order" do
      valid_attrs = %{address: "some address", city: "some city", email: "some email", even_weeks: true, fname: "some fname", is_member: true, lname: "some lname", location: :koroinen, order_type: :full, pcode: "some pcode", phone: "some phone", split_invoice: true}

      assert {:ok, %Order{} = order} = Orders.create_order(valid_attrs)
      assert order.address == "some address"
      assert order.city == "some city"
      assert order.email == "some email"
      assert order.even_weeks == true
      assert order.fname == "some fname"
      assert order.is_member == true
      assert order.lname == "some lname"
      assert order.location == :koroinen
      assert order.order_type == :full
      assert order.pcode == "some pcode"
      assert order.phone == "some phone"
      assert order.split_invoice == true
    end

    test "create_order/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Orders.create_order(@invalid_attrs)
    end

    test "update_order/2 with valid data updates the order" do
      order = order_fixture()
      update_attrs = %{address: "some updated address", city: "some updated city", email: "some updated email", even_weeks: false, fname: "some updated fname", is_member: false, lname: "some updated lname", location: :ocean, order_type: :everyother, pcode: "some updated pcode", phone: "some updated phone", split_invoice: false}

      assert {:ok, %Order{} = order} = Orders.update_order(order, update_attrs)
      assert order.address == "some updated address"
      assert order.city == "some updated city"
      assert order.email == "some updated email"
      assert order.even_weeks == false
      assert order.fname == "some updated fname"
      assert order.is_member == false
      assert order.lname == "some updated lname"
      assert order.location == :ocean
      assert order.order_type == :everyother
      assert order.pcode == "some updated pcode"
      assert order.phone == "some updated phone"
      assert order.split_invoice == false
    end

    test "update_order/2 with invalid data returns error changeset" do
      order = order_fixture()
      assert {:error, %Ecto.Changeset{}} = Orders.update_order(order, @invalid_attrs)
      assert order == Orders.get_order!(order.id)
    end

    test "delete_order/1 deletes the order" do
      order = order_fixture()
      assert {:ok, %Order{}} = Orders.delete_order(order)
      assert_raise Ecto.NoResultsError, fn -> Orders.get_order!(order.id) end
    end

    test "change_order/1 returns a order changeset" do
      order = order_fixture()
      assert %Ecto.Changeset{} = Orders.change_order(order)
    end
  end
end
