defmodule Osuuspuutarha.HarvestFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Osuuspuutarha.Harvest` context.
  """

  @doc """
  Generate a yield.
  """
  def yield_fixture(attrs \\ %{}) do
    {:ok, yield} =
      attrs
      |> Enum.into(%{
        amount: "120.5",
        date: ~D[2023-06-07],
        plant: :lettuce,
        unit: :kg
      })
      |> Osuuspuutarha.Harvest.create_yield()

    yield
  end
end
