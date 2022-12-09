defmodule ElectronicCommerce.Repo.Migrations.CreateAddressBooks do
  use Ecto.Migration

  def change do
    create table(:address_books) do
      add :name_of_recipient, :string, null: false
      add :postal_code, :string, null: false
      add :address, :string, null: false
      add :user_id, references(:users), null: false
    end
  end
end
