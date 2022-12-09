defmodule ElectronicCommerce.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :name, :string
    field :tel, :string
    field :email, :string
    has_many :address_books, ElectronicCommerce.AddressBook
    has_many :orders, ElectronicCommerce.Order
  end

  def changeset(user, params) do
    user
    |> cast(params, [:name, :tel, :email])
    |> validate_required(:name, message: "Please enter your name.")
    |> validate_tel()
    |> validate_email()
  end

  defp validate_tel(cs) do
    cs
    |> validate_required(:tel, message: "Please enter your tel.")
    |> validate_format(:tel, ~r/^(070|080|090)-\d{4}-\d{4}/, message: "Please put your cell phone number or - in between.")
    |> unique_constraint(:tel, message: "Tel has already been retrieved.")
    |> unsafe_validate_unique(:tel, ElectronicCommerce.Repo, message: "Tel has already been retrieved.")
  end

  defp validate_email(cs) do
    cs
    |> validate_required(:email, message: "Please enter your email.")
    |> validate_format(:email, ~r/^[^\s]+@[^\s]+$/, message: "Must include the @ symbol, do not include spaces.")
    |> unique_constraint(:email, message: "Email has already been retrieved.")
    |> unsafe_validate_unique(:email, ElectronicCommerce.Repo, message: "Email has already been retrieved.")
  end
end
