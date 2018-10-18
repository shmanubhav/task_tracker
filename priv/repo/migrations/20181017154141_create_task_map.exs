defmodule TaskTracker.Repo.Migrations.CreateTaskMap do
  use Ecto.Migration

  def change do
    create table(:task_map) do
      add :user_id, references(:users, on_delete: :delete_all), null: false
      add :task_id, references(:tasks, on_delete: :delete_all), null: false

      timestamps()
    end

    create index(:task_map, [:user_id])
    create index(:task_map, [:task_id])
  end
end
