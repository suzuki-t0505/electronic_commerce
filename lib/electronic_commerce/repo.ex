defmodule ElectronicCommerce.Repo do
  use Ecto.Repo,
    otp_app: :electronic_commerce,
    adapter: Ecto.Adapters.Postgres
end
