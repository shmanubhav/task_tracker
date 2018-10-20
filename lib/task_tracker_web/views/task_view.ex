defmodule TaskTrackerWeb.TaskView do
  use TaskTrackerWeb, :view

  def get_assignment_text(task) do
    task_id = task.id
    map_task = TaskTracker.TaskMaps.get_user_for_task(task_id)
    if map_task == nil do
      "Not Assigned"
    else
      TaskTracker.TaskMaps.get_user_for_task(task_id).name
    end
  end
end
