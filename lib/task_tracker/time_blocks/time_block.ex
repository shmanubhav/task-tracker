defmodule TaskTracker.TimeBlocks.TimeBlock do
  use Ecto.Schema
  import Ecto.Changeset


  schema "timeblocks" do
    field :end, :naive_datetime
    field :start, :naive_datetime
    belongs_to :task, TaskTracker.Tasks.Task

    timestamps()
  end

  @doc false
  def changeset(time_block, attrs) do
    time_block
    |> cast(attrs, [:start, :end, :task_id])
    |> validate_required([:task_id])
  end
end
