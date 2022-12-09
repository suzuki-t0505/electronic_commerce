defmodule ElectronicCommerce.Repo.Migrations.CreateOrderDetails do
  use Ecto.Migration

  def change do
    create table(:order_details) do
      add :number_ordered, :integer, null: false, default: 1
      add :total_price, :integer, null: false, default: 0
      add :item_id, references(:items), null: false
      add :order_id, references(:orders), null: false
    end
  end
end
