defmodule ElectronicCommerce.Item do
  use Ecto.Schema
  import Ecto.Changeset

  schema "items" do
    field :name, :string
    field :category, :string
    field :price, :integer, default: 0
    has_many :order_details, ElectronicCommerce.OrderDetail
    has_many :orders, through: [:order_details, :order]
    has_many :users, through: [:orders, :user]
  end

  def changeset(item, params) do
    item
    |> cast(params, [:name, :category, :price])
    |> validate_required(:name, message: "Please enter your name.")
    |> validate_required(:category, message: "Please enter your category.")
    |> validate_required(:price, message: "Please enter your price.")
  end
end
