defmodule Osuuspuutarha.SeasonFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Osuuspuutarha.Season` context.
  """

  @doc """
  Generate a calendar.
  """
  def calendar_fixture(attrs \\ %{}) do
    {:ok, calendar} =
      attrs
      |> Enum.into(%{
        is_picked_up: true,
        pickup_date: ~D[2023-06-06]
      })
      |> Osuuspuutarha.Season.create_calendar()

    calendar
  end
end
