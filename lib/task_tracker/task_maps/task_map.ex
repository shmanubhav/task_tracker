defmodule TaskTracker.TaskMaps.TaskMap do
  use Ecto.Schema
  import Ecto.Changeset


  schema "task_map" do
    belongs_to :user, TaskTracker.Users.User
    belongs_to :task, TaskTracker.Tasks.Task

    timestamps()
  end

  @doc false
  def changeset(task_map, attrs) do
    task_map
    |> cast(attrs, [:user_id, :task_id])
    |> validate_required([:user_id, :task_id])
  end
end
