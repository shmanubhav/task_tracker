defmodule TaskTracker.TaskMaps.TaskMap do
  use Ecto.Schema
  import Ecto.Changeset


  schema "task_map" do
    field :user_id, :id
    field :task_id, :id

    timestamps()
  end

  @doc false
  def changeset(task_map, attrs) do
    task_map
    |> cast(attrs, [])
    |> validate_required([])
  end
end
