defmodule Osuuspuutarha.Repo.Migrations.CreateOrders do
  use Ecto.Migration

  def change do
    create table(:orders) do
      add :order_type, :string
      add :location, :string
      add :fname, :string
      add :lname, :string
      add :address, :string
      add :pcode, :string
      add :city, :string
      add :phone, :string
      add :email, :string
      add :is_member, :boolean, default: false, null: false
      add :split_invoice, :boolean, default: false, null: false
      add :even_weeks, :boolean, default: false, null: false

      timestamps()
    end
  end
end
