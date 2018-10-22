defmodule TaskTrackerWeb.TaskMapController do
  use TaskTrackerWeb, :controller

  alias TaskTracker.TaskMaps
  alias TaskTracker.TaskMaps.TaskMap
  alias TaskTracker.Users
  alias TaskTracker.Users.User
  alias TaskTracker.Tasks
  alias TaskTracker.Tasks.Task
  alias TaskTracker.Repo

  def index(conn, _params) do
    task_map = TaskMaps.list_task_map()
    render(conn, "index.html", task_map: task_map)
  end

  def new(conn, _params) do
    # task_changeset = Tasks.change_task(%Task{})
    changeset = TaskMaps.change_task_map(%TaskMap{task: %Task{}, user: %User{}})
    users = TaskTracker.Users.list_users
    # tasks = TaskTracker.Tasks.list_tasks
    render(conn, "new.html", changeset: changeset, users: users)
  end

  def create(conn, %{"task_map" => task_map_params}) do
    # task_changeset = TaskTracker.Tasks.Task.changeset(%Task{}, task_map_params["task"])
    # task_map_changeset = TaskMap.changeset(%TaskMap{task: task_changeset}, task_map_params)
    # if task_map_changeset.valid? do
    #   task = ""
    #   Repo.transaction fn ->
    #     task_map = Repo.insert!(task_map_changeset)
    #     task = Ecto.Model.build(task_map, :task)
    #     Repo.insert!(task_map)
    #   end
    #   put_flash(conn, :info, "Task map created successfully.")
    #   redirect(conn, to: Routes.task_path(conn, :index))
    # else
    #   changeset = %Ecto.Changeset{}
    #   users = TaskTracker.Users.list_users
    #   tasks = TaskTracker.Tasks.list_tasks
    #   render(conn, "new.html", changeset: changeset, users: users, tasks: tasks)
    # end
    # case task_map_params do
    #   %{"task_maps" => task_params}
    #     ->  case Repo.TaskMaps.update_task_map(task_params) do
    #           {:ok, task_map} ->
    #             conn
    #             |> put_flash(:info, "Task map created successfully.")
    #             |> redirect(to: Routes.task_path(conn, :show, task_map.task_id))
    #           {:error, changeset} ->
    #             users = TaskTracker.Users.list_users
    #             render(conn, "new.html", changeset: changeset, users: users)
    #           end
    #   _
    #    ->   changeset = TaskMap.changeset(%TaskMap{}, task_map_params)
    #         users = TaskTracker.Users.list_users
    #         render(conn, "new.html", changeset: changeset, users: users)
    # end
    changeset = TaskMap.changeset(%TaskMap{}, task_map_params)
    case Repo.insert(changeset) do
      {:ok, task_map} ->
        conn
        |> put_flash(:info, "Task map created successfully.")
        |> redirect(to: Routes.task_path(conn, :show, task_map.task_id))

      {:error, changeset} ->
        users = TaskTracker.Users.list_users
        render(conn, "new.html", changeset: changeset, users: users)
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
