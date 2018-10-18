defmodule TaskTracker.Repo.Migrations.CreateTasks do
  use Ecto.Migration

  def change do
    create table(:tasks) do
      add :title, :string
      add :description, :text
      add :timeTaken, :integer
      add :complete, :boolean, default: false, null: false

      timestamps()
    end

  end
end
