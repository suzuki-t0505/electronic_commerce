import Config

config :electronic_commerce, ElectronicCommerce.Repo,
  database: "electronic_commerce_repo",
  username: "postgres",
  password: "postgres",
  hostname: "localhost"

config :electronic_commerce,
    ecto_repos: [ElectronicCommerce.Repo]
