defmodule ElectronicCommerce.MixProject do
  use Mix.Project

  def project do
    [
      app: :electronic_commerce,
      version: "0.1.0",
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {ElectronicCommerce.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ecto, "~> 3.9"},
      {:postgrex, "~> 0.16.5"},
      {:ecto_sql, "~> 3.9"}
    ]
  end
end
