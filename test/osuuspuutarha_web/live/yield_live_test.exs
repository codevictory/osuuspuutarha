defmodule OsuuspuutarhaWeb.YieldLiveTest do
  use OsuuspuutarhaWeb.ConnCase

  import Phoenix.LiveViewTest
  import Osuuspuutarha.HarvestFixtures

  @create_attrs %{amount: "120.5", date: %{day: 7, month: 6, year: 2023}, plant: :salad, unit: :kg}
  @update_attrs %{amount: "456.7", date: %{day: 8, month: 6, year: 2023}, plant: :carrot, unit: :kpl}
  @invalid_attrs %{amount: nil, date: %{day: 30, month: 2, year: 2023}, plant: nil, unit: nil}

  defp create_yield(_) do
    yield = yield_fixture()
    %{yield: yield}
  end

  describe "Index" do
    setup [:create_yield]

    test "lists all yields", %{conn: conn} do
      {:ok, _index_live, html} = live(conn, Routes.yield_index_path(conn, :index))

      assert html =~ "Listing Yields"
    end

    test "saves new yield", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.yield_index_path(conn, :index))

      assert index_live |> element("a", "New Yield") |> render_click() =~
               "New Yield"

      assert_patch(index_live, Routes.yield_index_path(conn, :new))

      assert index_live
             |> form("#yield-form", yield: @invalid_attrs)
             |> render_change() =~ "is invalid"

      {:ok, _, html} =
        index_live
        |> form("#yield-form", yield: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.yield_index_path(conn, :index))

      assert html =~ "Yield created successfully"
    end

    test "updates yield in listing", %{conn: conn, yield: yield} do
      {:ok, index_live, _html} = live(conn, Routes.yield_index_path(conn, :index))

      assert index_live |> element("#yield-#{yield.id} a", "Edit") |> render_click() =~
               "Edit Yield"

      assert_patch(index_live, Routes.yield_index_path(conn, :edit, yield))

      assert index_live
             |> form("#yield-form", yield: @invalid_attrs)
             |> render_change() =~ "is invalid"

      {:ok, _, html} =
        index_live
        |> form("#yield-form", yield: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.yield_index_path(conn, :index))

      assert html =~ "Yield updated successfully"
    end

    test "deletes yield in listing", %{conn: conn, yield: yield} do
      {:ok, index_live, _html} = live(conn, Routes.yield_index_path(conn, :index))

      assert index_live |> element("#yield-#{yield.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#yield-#{yield.id}")
    end
  end

  describe "Show" do
    setup [:create_yield]

    test "displays yield", %{conn: conn, yield: yield} do
      {:ok, _show_live, html} = live(conn, Routes.yield_show_path(conn, :show, yield))

      assert html =~ "Show Yield"
    end

    test "updates yield within modal", %{conn: conn, yield: yield} do
      {:ok, show_live, _html} = live(conn, Routes.yield_show_path(conn, :show, yield))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Yield"

      assert_patch(show_live, Routes.yield_show_path(conn, :edit, yield))

      assert show_live
             |> form("#yield-form", yield: @invalid_attrs)
             |> render_change() =~ "is invalid"

      {:ok, _, html} =
        show_live
        |> form("#yield-form", yield: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.yield_show_path(conn, :show, yield))

      assert html =~ "Yield updated successfully"
    end
  end
end
