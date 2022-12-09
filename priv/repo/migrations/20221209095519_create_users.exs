defmodule ElectronicCommerce.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string, null: false
      add :tel, :string, null: false
      add :email, :string, null: false
    end

    create unique_index(:users, :tel)
    create unique_index(:users, :email)
  end
end
