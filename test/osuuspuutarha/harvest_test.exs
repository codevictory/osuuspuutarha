defmodule Osuuspuutarha.HarvestTest do
  use Osuuspuutarha.DataCase

  alias Osuuspuutarha.Harvest

  describe "yields" do
    alias Osuuspuutarha.Harvest.Yield

    import Osuuspuutarha.HarvestFixtures

    @invalid_attrs %{amount: nil, date: nil, plant: nil, unit: nil}

    test "list_yields/0 returns all yields" do
      yield = yield_fixture()
      assert Harvest.list_yields() == [yield]
    end

    test "get_yield!/1 returns the yield with given id" do
      yield = yield_fixture()
      assert Harvest.get_yield!(yield.id) == yield
    end

    test "create_yield/1 with valid data creates a yield" do
      valid_attrs = %{amount: "120.5", date: ~D[2023-06-07], plant: :salad, unit: :kg}

      assert {:ok, %Yield{} = yield} = Harvest.create_yield(valid_attrs)
      assert yield.amount == Decimal.new("120.5")
      assert yield.date == ~D[2023-06-07]
      assert yield.plant == :salad
      assert yield.unit == :kg
    end

    test "create_yield/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Harvest.create_yield(@invalid_attrs)
    end

    test "update_yield/2 with valid data updates the yield" do
      yield = yield_fixture()
      update_attrs = %{amount: "456.7", date: ~D[2023-06-08], plant: :carrot, unit: :kpl}

      assert {:ok, %Yield{} = yield} = Harvest.update_yield(yield, update_attrs)
      assert yield.amount == Decimal.new("456.7")
      assert yield.date == ~D[2023-06-08]
      assert yield.plant == :carrot
      assert yield.unit == :kpl
    end

    test "update_yield/2 with invalid data returns error changeset" do
      yield = yield_fixture()
      assert {:error, %Ecto.Changeset{}} = Harvest.update_yield(yield, @invalid_attrs)
      assert yield == Harvest.get_yield!(yield.id)
    end

    test "delete_yield/1 deletes the yield" do
      yield = yield_fixture()
      assert {:ok, %Yield{}} = Harvest.delete_yield(yield)
      assert_raise Ecto.NoResultsError, fn -> Harvest.get_yield!(yield.id) end
    end

    test "change_yield/1 returns a yield changeset" do
      yield = yield_fixture()
      assert %Ecto.Changeset{} = Harvest.change_yield(yield)
    end
  end
end
