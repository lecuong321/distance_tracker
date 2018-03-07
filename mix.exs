defmodule DistanceTracker.Mixfile do
  use Mix.Project

  def project do
    [
      app: :distance_tracker,
      version: "0.0.1",
      elixir: "~> 1.4",
      elixirc_paths: elixirc_paths(Mix.env),
      compilers: [:phoenix, :gettext] ++ Mix.compilers,
      start_permanent: Mix.env == :prod,
      aliases: aliases(),
      deps: deps()
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {DistanceTracker, []},
      extra_applications: [:logger]
    ]
  end

  def application do
    [
      applications: [:comeonin]  #Add comeonin to OTP application
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "web", "test/support"]
  defp elixirc_paths(_),     do: ["lib", "web"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:phoenix, "~> 1.3.0-rc"},
      {:phoenix_pubsub, "~> 1.0"},
      {:phoenix_ecto, "~> 3.2"},
      {:postgrex, ">= 0.0.0"},
      {:gettext, "~> 0.11"},
      {:cowboy, "~> 1.0"},
      {:uuid, "~> 1.1"},
      {:phoenix_swagger, "~> 0.6.2"},
      {:cors_plug, "~> 1.4"},
      {:ex_json_schema, "~> 0.5.1"},
      {:guardian, "~> 0.14"},
      {:comeonin, "~> 3.0"} # Add comeonin to dependencies
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to create, migrate and run the seeds file at once:
  #
  #     $ mix ecto.setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      "test": ["ecto.create --quiet", "ecto.migrate", "swagger", "test"],
      "swagger": ["phx.swagger.generate priv/static/swagger.json --router DistanceTracker.Router --endpoint DistanceTracker.Endpoint"]
    ]
  end
end
