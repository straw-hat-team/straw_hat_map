# StrawHat.Map

[![Hex.pm](https://img.shields.io/hexpm/v/straw_hat_map.svg)](https://hex.pm/packages/straw_hat_map)
[![CI Status](https://travis-ci.org/straw-hat-team/straw_hat_map.svg?branch=master)](https://travis-ci.org/straw-hat-team/straw_hat_map)
[![Code Coverage](https://codecov.io/gh/straw-hat-team/straw_hat_map/branch/master/graph/badge.svg)](https://codecov.io/gh/straw-hat-team/straw_hat_map)

Map and addresses management.

## Configuration

`StrawHat.Map` requires an Ecto repository with `Geo.PostGIS.Extension`
extension enabled.

You need to create or extend your current PostgreSQL types:

```elixir
Postgrex.Types.define(
  MyApp.PostgresTypes,
  [Geo.PostGIS.Extension] ++ Ecto.Adapters.Postgres.extensions()
)
```

Then make sure that you add the types to your repository connection.

```elixir
# In your config files

config :my_app, MyApp.Repo,
  # ...
  types: MyApp.PostgresTypes
```

## Use cases

All the APIs are contain in the business use cases are under `Use Cases`
documentation section. Check the available modules and the public API.

You should be able to comprehend the API by reading the type spec and the
function name.

Please open an issue or even better make pull request about the documation if
you have any issues with it.

## Migrations

Since this library does not have any repository, it does not run any migration.
You will need to handle the migrations on your application that contains the
repository.