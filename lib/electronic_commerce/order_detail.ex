defmodule ElectronicCommerce.OrderDetail do
  use Ecto.Schema
  import Ecto.Changeset

  schema "order_details" do
    field :number_ordered, :integer, default: 1
    field :total_price, :integer, default: 0
    belongs_to :item, ElectronicCommerce.Item
    belongs_to :order, ElectronicCommerce.Order
  end
end
