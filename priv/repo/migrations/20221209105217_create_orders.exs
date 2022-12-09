defmodule ElectronicCommerce.Repo.Migrations.CreateOrders do
  use Ecto.Migration

  def change do
    create table(:orders) do
      add :order_date, :date, null: false
      add :total_price, :integer, null: false, default: 0
      add :user_id, references(:users), null: false
      add :address_book_id, references(:address_books), null: false
    end
  end
end
