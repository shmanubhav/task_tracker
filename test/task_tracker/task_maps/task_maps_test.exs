defmodule TaskTracker.TaskMapsTest do
  use TaskTracker.DataCase

  alias TaskTracker.TaskMaps

  describe "task_map" do
    alias TaskTracker.TaskMaps.TaskMap

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def task_map_fixture(attrs \\ %{}) do
      {:ok, task_map} =
        attrs
        |> Enum.into(@valid_attrs)
        |> TaskMaps.create_task_map()

      task_map
    end

    test "list_task_map/0 returns all task_map" do
      task_map = task_map_fixture()
      assert TaskMaps.list_task_map() == [task_map]
    end

    test "get_task_map!/1 returns the task_map with given id" do
      task_map = task_map_fixture()
      assert TaskMaps.get_task_map!(task_map.id) == task_map
    end

    test "create_task_map/1 with valid data creates a task_map" do
      assert {:ok, %TaskMap{} = task_map} = TaskMaps.create_task_map(@valid_attrs)
    end

    test "create_task_map/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = TaskMaps.create_task_map(@invalid_attrs)
    end

    test "update_task_map/2 with valid data updates the task_map" do
      task_map = task_map_fixture()
      assert {:ok, %TaskMap{} = task_map} = TaskMaps.update_task_map(task_map, @update_attrs)

      
    end

    test "update_task_map/2 with invalid data returns error changeset" do
      task_map = task_map_fixture()
      assert {:error, %Ecto.Changeset{}} = TaskMaps.update_task_map(task_map, @invalid_attrs)
      assert task_map == TaskMaps.get_task_map!(task_map.id)
    end

    test "delete_task_map/1 deletes the task_map" do
      task_map = task_map_fixture()
      assert {:ok, %TaskMap{}} = TaskMaps.delete_task_map(task_map)
      assert_raise Ecto.NoResultsError, fn -> TaskMaps.get_task_map!(task_map.id) end
    end

    test "change_task_map/1 returns a task_map changeset" do
      task_map = task_map_fixture()
      assert %Ecto.Changeset{} = TaskMaps.change_task_map(task_map)
    end
  end
end
