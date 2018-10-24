defmodule TaskTracker.Tasks.Task do
  use Ecto.Schema
  import Ecto.Changeset


  schema "tasks" do
    field :completed, :boolean, default: false
    field :desc, :string
    field :duration, :time
    field :title, :string
    belongs_to :user, TaskTracker.Users.User
    has_one :timeblock, TaskTracker.Timeblocks.Timeblock

    timestamps()
  end

  @doc false
  def changeset(task, attrs) do
    task
    |> cast(attrs, [:title, :desc, :completed, :duration, :user_id])
    |> validate_required([:title, :desc])
  end
end
