defmodule StrawHat.Map.Countries do
  @moduledoc """
  Defines functionality for countries management.
  """

  use StrawHat.Map.Interactor
  alias StrawHat.Map.{Country, State}

  @doc """
  Gets the list of countries.
  """
  @since "1.0.0"
  @spec get_countries(Scrivener.Config.t()) :: Scrivener.Page.t()
  def get_countries(pagination \\ []), do: Repo.paginate(Country, pagination)

  @doc """
  Creates a country.
  """
  @since "1.0.0"
  @spec create_country(Country.country_attrs()) ::
          {:ok, Country.t()} | {:error, Ecto.Changeset.t()}
  def create_country(country_attrs) do
    %Country{}
    |> Country.changeset(country_attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a country.
  """
  @since "1.0.0"
  @spec update_country(Country.t(), Country.country_attrs()) ::
          {:ok, Country.t()} | {:error, Ecto.Changeset.t()}
  def update_country(%Country{} = country, country_attrs) do
    country
    |> Country.changeset(country_attrs)
    |> Repo.update()
  end

  @doc """
  Destroys a country.
  """
  @since "1.0.0"
  @spec destroy_country(Country.t()) :: {:ok, Country.t()} | {:error, Ecto.Changeset.t()}
  def destroy_country(%Country{} = country), do: Repo.delete(country)

  @doc """
  Gets a country by `id`.
  """
  @since "1.0.0"
  @spec find_country(String.t()) :: {:ok, Country.t()} | {:error, Error.t()}
  def find_country(country_id) do
    country_id
    |> get_country()
    |> StrawHat.Response.from_value(
      Error.new("straw_hat_map.country.not_found", metadata: [country_id: country_id])
    )
  end

  @doc """
  Gets a country by `id`.
  """
  @since "1.0.0"
  @spec get_country(String.t()) :: Country.t() | nil | no_return
  def get_country(country_id), do: Repo.get(Country, country_id)

  @doc """
  Gets list of countries.
  """
  @since "1.0.0"
  @spec get_countries_by_ids([integer()]) :: [Country.t()] | no_return()
  def get_countries_by_ids(country_ids) do
    query = from(country in Country, where: country.id in ^country_ids)
    Repo.all(query)
  end

  @doc """
  Gets list of states.
  """
  @since "1.0.0"
  @spec get_states([integer()]) :: [State.t()] | no_return()
  def get_states(country_ids) when is_list(country_ids) do
    query = from(state in State, where: state.country_id in ^country_ids)
    Repo.all(query)
  end
end