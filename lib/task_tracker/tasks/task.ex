defmodule TaskTracker.Tasks.Task do
  use Ecto.Schema
  import Ecto.Changeset


  schema "tasks" do
    field :completed, :boolean, default: false
    field :description, :string
    field :title, :string
    belongs_to :user, TaskTracker.Users.User
    has_one :timeblock, TaskTracker.TimeBlocks.TimeBlock

    timestamps()
  end

  @doc false
  def changeset(task, attrs) do
    task
    |> cast(attrs, [:title, :description, :completed, :user_id])
    |> validate_required([:title, :description])
  end
end
