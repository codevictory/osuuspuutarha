defmodule Osuuspuutarha.Harvest do
  @moduledoc """
  The Harvest context.
  """

  import Ecto.Query, warn: false
  alias Osuuspuutarha.Repo

  alias Osuuspuutarha.Harvest.Yield

  @doc """
  Returns the list of yields.

  ## Examples

      iex> list_yields()
      [%Yield{}, ...]

  """
  def list_yields do
    Repo.all(Yield)
  end

  @doc """
  Gets a single yield.

  Raises `Ecto.NoResultsError` if the Yield does not exist.

  ## Examples

      iex> get_yield!(123)
      %Yield{}

      iex> get_yield!(456)
      ** (Ecto.NoResultsError)

  """
  def get_yield!(id), do: Repo.get!(Yield, id)

  @doc """
  Creates a yield.

  ## Examples

      iex> create_yield(%{field: value})
      {:ok, %Yield{}}

      iex> create_yield(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_yield(attrs \\ %{}) do
    %Yield{}
    |> Yield.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a yield.

  ## Examples

      iex> update_yield(yield, %{field: new_value})
      {:ok, %Yield{}}

      iex> update_yield(yield, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_yield(%Yield{} = yield, attrs) do
    yield
    |> Yield.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a yield.

  ## Examples

      iex> delete_yield(yield)
      {:ok, %Yield{}}

      iex> delete_yield(yield)
      {:error, %Ecto.Changeset{}}

  """
  def delete_yield(%Yield{} = yield) do
    Repo.delete(yield)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking yield changes.

  ## Examples

      iex> change_yield(yield)
      %Ecto.Changeset{data: %Yield{}}

  """
  def change_yield(%Yield{} = yield, attrs \\ %{}) do
    Yield.changeset(yield, attrs)
  end
end
