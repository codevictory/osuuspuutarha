defmodule Osuuspuutarha.Orders.Order do
  use Ecto.Schema
  import Ecto.Changeset

  schema "orders" do
    field :address, :string
    field :city, :string
    field :email, :string
    field :even_weeks, :boolean, default: false
    field :fname, :string
    field :is_member, :boolean, default: false
    field :lname, :string

    field :location, Ecto.Enum,
      values: [
        :koroinen,
        :ocean,
        :raisio,
        :naantali,
        :viherlassila,
        :kirjakahvila,
        :askainen,
        :livonsaari
      ]

    field :order_type, Ecto.Enum, values: [:full, :everyother, :elo, :community]
    field :pcode, :string
    field :phone, :string
    field :split_invoice, :boolean, default: false

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
      :even_weeks
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
      :split_invoice
    ])
  end
end
