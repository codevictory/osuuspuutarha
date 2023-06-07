defmodule OsuuspuutarhaWeb.CalendarLiveTest do
  use OsuuspuutarhaWeb.ConnCase

  import Phoenix.LiveViewTest
  import Osuuspuutarha.SeasonFixtures

  @create_attrs %{is_picked_up: true, pickup_date: %{day: 6, month: 6, year: 2023}}
  @update_attrs %{is_picked_up: false, pickup_date: %{day: 7, month: 6, year: 2023}}
  @invalid_attrs %{is_picked_up: false, pickup_date: %{day: 30, month: 2, year: 2023}}

  defp create_calendar(_) do
    calendar = calendar_fixture()
    %{calendar: calendar}
  end

  describe "Index" do
    setup [:create_calendar]

    test "lists all calendars", %{conn: conn} do
      {:ok, _index_live, html} = live(conn, Routes.calendar_index_path(conn, :index))

      assert html =~ "Listing Calendars"
    end

    test "saves new calendar", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.calendar_index_path(conn, :index))

      assert index_live |> element("a", "New Calendar") |> render_click() =~
               "New Calendar"

      assert_patch(index_live, Routes.calendar_index_path(conn, :new))

      assert index_live
             |> form("#calendar-form", calendar: @invalid_attrs)
             |> render_change() =~ "is invalid"

      {:ok, _, html} =
        index_live
        |> form("#calendar-form", calendar: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.calendar_index_path(conn, :index))

      assert html =~ "Calendar created successfully"
    end

    test "updates calendar in listing", %{conn: conn, calendar: calendar} do
      {:ok, index_live, _html} = live(conn, Routes.calendar_index_path(conn, :index))

      assert index_live |> element("#calendar-#{calendar.id} a", "Edit") |> render_click() =~
               "Edit Calendar"

      assert_patch(index_live, Routes.calendar_index_path(conn, :edit, calendar))

      assert index_live
             |> form("#calendar-form", calendar: @invalid_attrs)
             |> render_change() =~ "is invalid"

      {:ok, _, html} =
        index_live
        |> form("#calendar-form", calendar: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.calendar_index_path(conn, :index))

      assert html =~ "Calendar updated successfully"
    end

    test "deletes calendar in listing", %{conn: conn, calendar: calendar} do
      {:ok, index_live, _html} = live(conn, Routes.calendar_index_path(conn, :index))

      assert index_live |> element("#calendar-#{calendar.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#calendar-#{calendar.id}")
    end
  end

  describe "Show" do
    setup [:create_calendar]

    test "displays calendar", %{conn: conn, calendar: calendar} do
      {:ok, _show_live, html} = live(conn, Routes.calendar_show_path(conn, :show, calendar))

      assert html =~ "Show Calendar"
    end

    test "updates calendar within modal", %{conn: conn, calendar: calendar} do
      {:ok, show_live, _html} = live(conn, Routes.calendar_show_path(conn, :show, calendar))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Calendar"

      assert_patch(show_live, Routes.calendar_show_path(conn, :edit, calendar))

      assert show_live
             |> form("#calendar-form", calendar: @invalid_attrs)
             |> render_change() =~ "is invalid"

      {:ok, _, html} =
        show_live
        |> form("#calendar-form", calendar: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.calendar_show_path(conn, :show, calendar))

      assert html =~ "Calendar updated successfully"
    end
  end
end
