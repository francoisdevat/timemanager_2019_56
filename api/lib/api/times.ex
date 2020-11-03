defmodule Gotham.Times do
  @moduledoc """
  The Times context.
  """

  import Ecto.Query, warn: false
  alias Gotham.Repo

  alias Gotham.Times.Hour

  @doc """
  Returns the list of hours.

  ## Examples

      iex> list_hours()
      [%Hour{}, ...]

  """
  def list_hours do
    # Repo.all(Hour)
    Repo.all(from h in Hour,
    order_by: h.end)
  end

  @doc """
  Gets a single hour.

  Raises `Ecto.NoResultsError` if the Hour does not exist.

  ## Examples

      iex> get_hour!(123)
      %Hour{}

      iex> get_hour!(456)
      ** (Ecto.NoResultsError)

  """
  def get_hour!(id), do: Repo.get!(Hour, id)

  def get_hourbyuser!(user_id) do
   from(h in Hour,
   where: h.user_id == ^user_id)
   |> Repo.all
   |> Repo.preload([:user, :team])
  end
  
  def get_hourbyteam!(team_id) do
   from(h in Hour,
   where: h.team_id == ^team_id)
   |> Repo.all
   |> Repo.preload([:user, :team])
  end

  def get_hourbytime!(start, endtime) do
    from(h in Hour,
    where: h.start > ^start,
    where: h.end < ^endtime)
    |> Repo.all
    |> Repo.preload([:user, :team])
  end
  
  @doc """
  Creates a hour.

  ## Examples

      iex> create_hour(%{field: value})
      {:ok, %Hour{}}

      iex> create_hour(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_hour(attrs \\ %{}) do
    %Hour{}
    |> Hour.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a hour.

  ## Examples

      iex> update_hour(hour, %{field: new_value})
      {:ok, %Hour{}}

      iex> update_hour(hour, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_hour(%Hour{} = hour, attrs) do
    hour
    |> Hour.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a hour.

  ## Examples

      iex> delete_hour(hour)
      {:ok, %Hour{}}

      iex> delete_hour(hour)
      {:error, %Ecto.Changeset{}}

  """
  def delete_hour(%Hour{} = hour) do
    Repo.delete(hour)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking hour changes.

  ## Examples

      iex> change_hour(hour)
      %Ecto.Changeset{data: %Hour{}}

  """
  def change_hour(%Hour{} = hour, attrs \\ %{}) do
    Hour.changeset(hour, attrs)
  end
end
