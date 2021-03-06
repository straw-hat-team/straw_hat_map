defmodule StrawHat.Map.MixProject do
  use Mix.Project

  @name :straw_hat_map
  @version "2.0.0"
  @elixir_version "~> 1.7"
  @source_url "https://github.com/straw-hat-team/straw_hat_map"

  def project do
    production? = Mix.env() == :prod

    [
      name: "StrawHat.Map",
      description: "Map and Addresses Management library",
      app: @name,
      version: @version,
      deps: deps(),
      elixir: @elixir_version,
      elixirc_paths: elixirc_paths(Mix.env()),
      build_embedded: production?,
      start_permanent: production?,
      aliases: aliases(),
      test_coverage: test_coverage(),
      preferred_cli_env: cli_env(),
      package: package(),
      docs: docs()
    ]
  end

  def application do
    [extra_applications: [:logger]]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp deps do
    [
      {:straw_hat, "~> 0.4"},
      {:ecto, "~> 3.0"},
      {:ecto_sql, "~> 3.0"},
      {:postgrex, ">= 0.0.0"},
      {:scrivener_ecto, "~> 2.0"},
      {:geo_postgis, "~> 3.0"},

      # Testing
      {:ex_machina, ">= 0.0.0", only: [:test]},
      {:faker, ">= 0.0.0", only: [:test]},

      # Tools
      {:dialyxir, ">= 0.0.0", only: [:dev], runtime: false},
      {:credo, ">= 0.0.0", only: [:dev, :test], runtime: false},
      {:excoveralls, ">= 0.0.0", only: [:test], runtime: false},
      {:ex_doc, ">= 0.0.0", only: [:dev], runtime: false}
    ]
  end

  defp test_coverage do
    [tool: ExCoveralls]
  end

  defp cli_env do
    [
      "ecto.reset": :test,
      "ecto.setup": :test,
      "coveralls.html": :test,
      "coveralls.json": :test
    ]
  end

  defp aliases do
    [
      "ecto.setup": ["ecto.create", "ecto.migrate"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: ["ecto.create --quiet", "ecto.migrate", "test --trace"]
    ]
  end

  defp package do
    [
      name: @name,
      files: [
        "lib",
        "priv",
        "mix.exs",
        "README*",
        "LICENSE*"
      ],
      maintainers: ["Yordis Prieto", "Osley Zorrilla"],
      licenses: ["MIT"],
      links: %{"GitHub" => @source_url}
    ]
  end

  defp docs do
    [
      main: "readme",
      homepage_url: @source_url,
      source_ref: "v#{@version}",
      source_url: @source_url,
      extras: ["README.md"],
      groups_for_modules: [
        "Use Cases": [
          StrawHat.Map.Continents,
          StrawHat.Map.Countries,
          StrawHat.Map.States,
          StrawHat.Map.Counties,
          StrawHat.Map.Cities,
          StrawHat.Map.Locations,
          StrawHat.Map.Addresses
        ],
        Entities: [
          StrawHat.Map.Continent,
          StrawHat.Map.Country,
          StrawHat.Map.State,
          StrawHat.Map.County,
          StrawHat.Map.City,
          StrawHat.Map.Location,
          StrawHat.Map.Address
        ],
        Migrations: [
          StrawHat.Map.Migrations.CreateCountriesTable,
          StrawHat.Map.Migrations.CreateStatesTable,
          StrawHat.Map.Migrations.CreateCountiesTable,
          StrawHat.Map.Migrations.CreateCitiesTable,
          StrawHat.Map.Migrations.CreateAddressesTable,
          StrawHat.Map.Migrations.CreateLocationsTable,
          StrawHat.Map.Migrations.AddPostgisPlugin,
          StrawHat.Map.Migrations.AddGeoLocationToLocationsTable,
          StrawHat.Map.Migrations.AddPostalCodeRuleToCountries
        ]
      ]
    ]
  end
end
