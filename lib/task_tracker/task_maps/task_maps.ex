defmodule TaskTracker.TaskMaps do
  @moduledoc """
  The TaskMaps context.
  """

  import Ecto.Query, warn: false
  alias TaskTracker.Repo

  alias TaskTracker.TaskMaps.TaskMap

  @doc """
  Returns the list of task_map.

  ## Examples

      iex> list_task_map()
      [%TaskMap{}, ...]

  """
  def list_task_map do
    Repo.all(TaskMap)
  end

  @doc """
  Gets a single task_map.

  Raises `Ecto.NoResultsError` if the Task map does not exist.

  ## Examples

      iex> get_task_map!(123)
      %TaskMap{}

      iex> get_task_map!(456)
      ** (Ecto.NoResultsError)

  """
  def get_task_map!(id), do: Repo.get!(TaskMap, id)

  @doc """
  Creates a task_map.

  ## Examples

      iex> create_task_map(%{field: value})
      {:ok, %TaskMap{}}

      iex> create_task_map(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_task_map(attrs \\ %{}) do
    %TaskMap{}
    |> TaskMap.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a task_map.

  ## Examples

      iex> update_task_map(task_map, %{field: new_value})
      {:ok, %TaskMap{}}

      iex> update_task_map(task_map, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_task_map(%TaskMap{} = task_map, attrs) do
    task_map
    |> TaskMap.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a TaskMap.

  ## Examples

      iex> delete_task_map(task_map)
      {:ok, %TaskMap{}}

      iex> delete_task_map(task_map)
      {:error, %Ecto.Changeset{}}

  """
  def delete_task_map(%TaskMap{} = task_map) do
    Repo.delete(task_map)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking task_map changes.

  ## Examples

      iex> change_task_map(task_map)
      %Ecto.Changeset{source: %TaskMap{}}

  """
  def change_task_map(%TaskMap{} = task_map) do
    TaskMap.changeset(task_map, %{})
  end
end
