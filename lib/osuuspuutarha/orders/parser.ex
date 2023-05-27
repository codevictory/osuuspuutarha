defmodule Osuuspuutarha.Orders.Parser do
  def parse_boolean(flag) do
    if flag == true do
      "Kyllä"
    else
      "Ei"
    end
  end

  @spec parse_order_type(:community | :elo | :everyother | :full) :: <<_::64, _::_*8>>
  def parse_order_type(:full) do
    "Joka viikko"
  end

  def parse_order_type(:everyother) do
    "Joka toinen viikko"
  end

  def parse_order_type(:elo) do
    "Elotilaus"
  end

  def parse_order_type(:community) do
    "Osuuskuntatoiminta"
  end

  @spec parse_location(
          :askainen
          | :kirjakahvila
          | :koroinen
          | :livonsaari
          | :naantali
          | :ocean
          | :raisio
          | :viherlassila
        ) :: <<_::48, _::_*16>>
  def parse_location(:koroinen) do
    "Koroinen"
  end

  def parse_location(:ocean) do
    "Ocean Spirit"
  end

  def parse_location(:raisio) do
    "Raisio"
  end

  def parse_location(:naantali) do
    "Naantali"
  end

  def parse_location(:viherlassila) do
    "Viherlassila"
  end

  def parse_location(:kirjakahvila) do
    "Kirjakahvila"
  end

  def parse_location(:askainen) do
    "Askainen"
  end

  def parse_location(:livonsaari) do
    "Livonsaari"
  end

  @spec parse_date(atom | %{:day => any, :month => any, :year => any, optional(any) => any}) ::
          <<_::16, _::_*8>>
  def parse_date(date) do
    "#{date.day}.#{date.month}.#{date.year}"
  end
end
