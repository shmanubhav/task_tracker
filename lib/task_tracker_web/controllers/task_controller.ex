defmodule TaskTrackerWeb.TaskController do
  use TaskTrackerWeb, :controller

  alias TaskTracker.Tasks
  alias TaskTracker.Tasks.Task
  alias TaskTracker.TaskMaps
  alias TaskTracker.TaskMaps.TaskMap

  def index(conn, _params) do
    tasks = Tasks.list_tasks()
    task_map = TaskMaps.list_task_map()
    render(conn, "index.html", tasks: tasks, task_map: task_map)
  end

  def new(conn, _params) do
    changeset = Tasks.change_task(%Task{})
    task_map = TaskMaps.list_task_map()
    render(conn, "new.html", changeset: changeset, task_map: task_map)
  end

  def create(conn, %{"task" => task_params}) do
    case Tasks.create_task(task_params) do
      {:ok, task} ->
        conn
        |> put_flash(:info, "Task created successfully.")
        |> redirect(to: Routes.task_path(conn, :show, task))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    task = Tasks.get_task!(id)
    task_map = TaskMaps.list_task_map()
    user_id = get_session(conn, :user_id)
    item_cset = TaskMaps.change_task_map(%TaskMaps.TaskMap{user_id: user_id, task_id: task.id})
    map_task = TaskTracker.TaskMaps.get_map_for_task(id)
    render(conn, "show.html", task: task, task_map: task_map, map_task: map_task)
  end

  def edit(conn, %{"id" => id}) do
    task = Tasks.get_task!(id)
    changeset = Tasks.change_task(task)
    task_map = TaskMaps.list_task_map()
    render(conn, "edit.html", task: task, changeset: changeset, task_map: task_map)
  end

  def update(conn, %{"id" => id, "task" => task_params}) do
    task = Tasks.get_task!(id)

    case Tasks.update_task(task, task_params) do
      {:ok, task} ->
        conn
        |> put_flash(:info, "Task updated successfully.")
        |> redirect(to: Routes.task_path(conn, :show, task))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", task: task, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    task = Tasks.get_task!(id)
    {:ok, _task} = Tasks.delete_task(task)

    conn
    |> put_flash(:info, "Task deleted successfully.")
    |> redirect(to: Routes.task_path(conn, :index))
  end
end
