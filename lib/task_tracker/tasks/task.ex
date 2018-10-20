defmodule TaskTracker.Tasks.Task do
  use Ecto.Schema
  import Ecto.Changeset


  schema "tasks" do
    field :complete, :boolean, default: false
    field :description, :string
    field :timeTaken, :integer
    field :title, :string

    # TODO: has_many

    timestamps()
  end

  @doc false
  def changeset(task, attrs) do
    task
    |> cast(attrs, [:title, :description, :timeTaken, :complete])
    |> validate_required([:title, :description, :timeTaken, :complete])
  end
end
