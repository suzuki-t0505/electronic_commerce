defmodule ElectronicCommerce.AddressBook do
  use Ecto.Schema
  import Ecto.Changeset

  schema "address_books" do
    field :name_of_recipient, :string
    field :postal_code, :string
    field :address, :string
    belongs_to :user, ElectronicCommerce.User
  end

  def changeset(address_book, params) do
    address_book
    |> cast(params, [:name_of_recipient, :postal_code, :address])
    |> validate_required(:name_of_recipient, message: "Please enter your name of recipient.")
    |> validate_required(:postal_code, message: "Please enter your postal code.")
    |> validate_format(:postal_code, ~r/^\d{3}-\d{4}$/, message: "Please put the correct zip code or - in between.")
    |> validate_required(:address, message: "Please enter your address.")
  end
end
