defmodule TaskTrackerWeb.TaskMapController do
  use TaskTrackerWeb, :controller

  alias TaskTracker.TaskMaps
  alias TaskTracker.TaskMaps.TaskMap
  alias TaskTracker.Users

  def index(conn, _params) do
    task_map = TaskMaps.list_task_map()
    render(conn, "index.html", task_map: task_map)
  end

  def new(conn, _params) do
    changeset = TaskMaps.change_task_map(%TaskMap{})
    users = TaskTracker.Users.list_users
    render(conn, "new.html", changeset: changeset, users: users)
  end

  def create(conn, %{"task_map" => task_map_params}) do
    case TaskMaps.create_task_map(task_map_params) do
      {:ok, task_map} ->
        conn
        |> put_flash(:info, "Task map created successfully.")
        |> redirect(to: Routes.task_path(conn, :show, task_map.task_id))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    task_map = TaskMaps.get_task_map!(id)
    render(conn, "show.html", task_map: task_map)
  end

  def edit(conn, %{"id" => id}) do
    task_map = TaskMaps.get_task_map!(id)
    changeset = TaskMaps.change_task_map(task_map)
    users = TaskTracker.Users.list_users
    render(conn, "edit.html", task_map: task_map, changeset: changeset, users: users)
  end

  def update(conn, %{"id" => id, "task_map" => task_map_params}) do
    task_map = TaskMaps.get_task_map!(id)
    users = TaskTracker.Users.list_users

    case TaskMaps.update_task_map(task_map, task_map_params) do
      {:ok, task_map} ->
        conn
        |> put_flash(:info, "Task map updated successfully.")
        |> redirect(to: Routes.task_map_path(conn, :show, task_map.task_id))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", task_map: task_map, changeset: changeset, users: users)
    end
  end

  def delete(conn, %{"id" => id}) do
    task_map = TaskMaps.get_task_map!(id)
    {:ok, _task_map} = TaskMaps.delete_task_map(task_map)

    conn
    |> put_flash(:info, "Task map deleted successfully.")
    |> redirect(to: Routes.task_map_path(conn, :index))
  end
end
