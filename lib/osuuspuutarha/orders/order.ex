defmodule Osuuspuutarha.Orders.Order do
  use Ecto.Schema
  import Ecto.Changeset

  schema "orders" do
    field :address, :string
    field :city, :string
    field :email, :string
    field :even_weeks, :boolean, default: false
    field :fname, :string
    field :is_member, :boolean
    field :lname, :string

    field :location, Ecto.Enum,
      values: [
        :koroinen,
        :kissakahvila,
        :raisio,
        :naantali,
        :viherlassila,
        :kirjakahvila,
        :askainen,
        :livonsaari,
        :merimasku,
        :masku
      ]

    field :order_type, Ecto.Enum,
      values: [
        :full,
        :everyother,
        :elo,
        :community,
        :full_pikku,
        :everyother_pikku,
        :elo_pikku,
        :community_pikku
      ]

    field :pcode, :string
    field :phone, :string
    field :split_invoice, :boolean, default: false
    field :early_bird, :boolean, default: false

    timestamps()
  end

  @doc false
  def changeset(order, attrs) do
    order
    |> cast(attrs, [
      :order_type,
      :location,
      :fname,
      :lname,
      :address,
      :pcode,
      :city,
      :phone,
      :email,
      :is_member,
      :split_invoice,
      :even_weeks,
      :early_bird
    ])
    |> validate_required([
      :order_type,
      :location,
      :fname,
      :lname,
      :address,
      :pcode,
      :city,
      :phone,
      :email,
      :is_member,
      :split_invoice,
      :early_bird
    ])
  end
end
