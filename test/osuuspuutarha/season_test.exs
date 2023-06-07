defmodule Osuuspuutarha.SeasonTest do
  use Osuuspuutarha.DataCase

  alias Osuuspuutarha.Season

  describe "calendars" do
    alias Osuuspuutarha.Season.Calendar

    import Osuuspuutarha.SeasonFixtures

    @invalid_attrs %{is_picked_up: nil, pickup_date: nil}

    test "list_calendars/0 returns all calendars" do
      calendar = calendar_fixture()
      assert Season.list_calendars() == [calendar]
    end

    test "get_calendar!/1 returns the calendar with given id" do
      calendar = calendar_fixture()
      assert Season.get_calendar!(calendar.id) == calendar
    end

    test "create_calendar/1 with valid data creates a calendar" do
      valid_attrs = %{is_picked_up: true, pickup_date: ~D[2023-06-06]}

      assert {:ok, %Calendar{} = calendar} = Season.create_calendar(valid_attrs)
      assert calendar.is_picked_up == true
      assert calendar.pickup_date == ~D[2023-06-06]
    end

    test "create_calendar/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Season.create_calendar(@invalid_attrs)
    end

    test "update_calendar/2 with valid data updates the calendar" do
      calendar = calendar_fixture()
      update_attrs = %{is_picked_up: false, pickup_date: ~D[2023-06-07]}

      assert {:ok, %Calendar{} = calendar} = Season.update_calendar(calendar, update_attrs)
      assert calendar.is_picked_up == false
      assert calendar.pickup_date == ~D[2023-06-07]
    end

    test "update_calendar/2 with invalid data returns error changeset" do
      calendar = calendar_fixture()
      assert {:error, %Ecto.Changeset{}} = Season.update_calendar(calendar, @invalid_attrs)
      assert calendar == Season.get_calendar!(calendar.id)
    end

    test "delete_calendar/1 deletes the calendar" do
      calendar = calendar_fixture()
      assert {:ok, %Calendar{}} = Season.delete_calendar(calendar)
      assert_raise Ecto.NoResultsError, fn -> Season.get_calendar!(calendar.id) end
    end

    test "change_calendar/1 returns a calendar changeset" do
      calendar = calendar_fixture()
      assert %Ecto.Changeset{} = Season.change_calendar(calendar)
    end
  end
end
