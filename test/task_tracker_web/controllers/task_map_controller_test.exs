defmodule TaskTrackerWeb.TaskMapControllerTest do
  use TaskTrackerWeb.ConnCase

  alias TaskTracker.TaskMaps

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:task_map) do
    {:ok, task_map} = TaskMaps.create_task_map(@create_attrs)
    task_map
  end

  describe "index" do
    test "lists all task_map", %{conn: conn} do
      conn = get(conn, Routes.task_map_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Task map"
    end
  end

  describe "new task_map" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.task_map_path(conn, :new))
      assert html_response(conn, 200) =~ "New Task map"
    end
  end

  describe "create task_map" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.task_map_path(conn, :create), task_map: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.task_map_path(conn, :show, id)

      conn = get(conn, Routes.task_map_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Task map"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.task_map_path(conn, :create), task_map: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Task map"
    end
  end

  describe "edit task_map" do
    setup [:create_task_map]

    test "renders form for editing chosen task_map", %{conn: conn, task_map: task_map} do
      conn = get(conn, Routes.task_map_path(conn, :edit, task_map))
      assert html_response(conn, 200) =~ "Edit Task map"
    end
  end

  describe "update task_map" do
    setup [:create_task_map]

    test "redirects when data is valid", %{conn: conn, task_map: task_map} do
      conn = put(conn, Routes.task_map_path(conn, :update, task_map), task_map: @update_attrs)
      assert redirected_to(conn) == Routes.task_map_path(conn, :show, task_map)

      conn = get(conn, Routes.task_map_path(conn, :show, task_map))
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, task_map: task_map} do
      conn = put(conn, Routes.task_map_path(conn, :update, task_map), task_map: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Task map"
    end
  end

  describe "delete task_map" do
    setup [:create_task_map]

    test "deletes chosen task_map", %{conn: conn, task_map: task_map} do
      conn = delete(conn, Routes.task_map_path(conn, :delete, task_map))
      assert redirected_to(conn) == Routes.task_map_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.task_map_path(conn, :show, task_map))
      end
    end
  end

  defp create_task_map(_) do
    task_map = fixture(:task_map)
    {:ok, task_map: task_map}
  end
end
