defmodule ElectronicCommerce.Order do
  use Ecto.Schema
  import Ecto.Changeset

  schema "orders" do
    field :order_date, :date
    field :total_price, :integer, default: 0
    belongs_to :user, ElectronicCommerce.User
    belongs_to :address_book, ElectronicCommerce.AddressBook
    has_many :order_details, ElectronicCommerce.OrderDetail
    has_many :items, through: [:order_details, :item]
  end

  def changeset(order, params) do
    order
    |> cast(params, [:order_date, :total_price])
    |> validate_required(:order_date, message: "Please enter your order date.")
    |> validate_required(:total_price, message: "Please enter your total price.")
  end
end
