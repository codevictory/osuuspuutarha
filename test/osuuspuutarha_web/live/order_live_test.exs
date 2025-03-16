defmodule OsuuspuutarhaWeb.OrderLiveTest do
  use OsuuspuutarhaWeb.ConnCase

  import Phoenix.LiveViewTest
  import Osuuspuutarha.OrdersFixtures

  @create_attrs %{
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
    split_invoice: true,
    early_bird: true
  }
  @update_attrs %{
    address: "some updated address",
    city: "some updated city",
    email: "some updated email",
    even_weeks: false,
    fname: "some updated fname",
    is_member: false,
    lname: "some updated lname",
    location: :kissakahvila,
    order_type: :everyother,
    pcode: "some updated pcode",
    phone: "some updated phone",
    split_invoice: false,
    early_bird: false
  }
  @invalid_attrs %{
    address: nil,
    city: nil,
    email: nil,
    even_weeks: false,
    fname: nil,
    is_member: false,
    lname: nil,
    location: nil,
    order_type: nil,
    pcode: nil,
    phone: nil,
    split_invoice: false,
    early_bird: false
  }

  defp process_order(_) do
    order = order_fixture()
    %{order: order}
  end

  describe "Index" do
    setup [:process_order]

    test "lists all orders", %{conn: conn, order: order} do
      {:ok, _index_live, html} = live(conn, Routes.order_index_path(conn, :index))

      assert html =~ "Listing Orders"
      assert html =~ order.address
    end

    test "saves new order", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.order_index_path(conn, :index))

      assert index_live |> element("a", "New Order") |> render_click() =~
               "New Order"

      assert_patch(index_live, Routes.order_index_path(conn, :new))

      assert index_live
             |> form("#order-form", order: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#order-form", order: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.order_index_path(conn, :index))

      assert html =~ "Order created successfully"
      assert html =~ "some address"
    end

    test "updates order in listing", %{conn: conn, order: order} do
      {:ok, index_live, _html} = live(conn, Routes.order_index_path(conn, :index))

      assert index_live |> element("#order-#{order.id} a", "Edit") |> render_click() =~
               "Edit Order"

      assert_patch(index_live, Routes.order_index_path(conn, :edit, order))

      assert index_live
             |> form("#order-form", order: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#order-form", order: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.order_index_path(conn, :index))

      assert html =~ "Order updated successfully"
      assert html =~ "some updated address"
    end

    test "deletes order in listing", %{conn: conn, order: order} do
      {:ok, index_live, _html} = live(conn, Routes.order_index_path(conn, :index))

      assert index_live |> element("#order-#{order.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#order-#{order.id}")
    end
  end

  describe "Show" do
    setup [:process_order]

    test "displays order", %{conn: conn, order: order} do
      {:ok, _show_live, html} = live(conn, Routes.order_show_path(conn, :show, order))

      assert html =~ "Show Order"
      assert html =~ order.address
    end

    test "updates order within modal", %{conn: conn, order: order} do
      {:ok, show_live, _html} = live(conn, Routes.order_show_path(conn, :show, order))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Order"

      assert_patch(show_live, Routes.order_show_path(conn, :edit, order))

      assert show_live
             |> form("#order-form", order: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#order-form", order: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.order_show_path(conn, :show, order))

      assert html =~ "Order updated successfully"
      assert html =~ "some updated address"
    end
  end
end
