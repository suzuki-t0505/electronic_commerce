defmodule ElectronicCommerce.OrderDetail do
  use Ecto.Schema
  import Ecto.Changeset

  schema "order_details" do
    field :number_ordered, :integer, default: 1
    field :total_price, :integer, default: 0
    belongs_to :item, ElectronicCommerce.Item
    belongs_to :order, ElectronicCommerce.Order
  end

  def changeset(order_detail, params) do
    order_detail
    |> cast(params, [:number_ordered, :total_price])
    |> validate_required(:number_ordered, message: "Please enter your number ordered.")
    |> validate_number(:number_ordered, greater_than: 0, message: "Please enter 1 or more.")
    |> validate_required(:total_price, message: "Please enter your total price.")
  end
end
