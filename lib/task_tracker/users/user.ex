# Use this tutorial to validate inputs when creating a user:
# https://medium.com/@diamondgfx/testing-validations-in-elixir-and-ecto-677bd8a071a1
defmodule TaskTracker.Users.User do
  use Ecto.Schema
  import Ecto.Changeset


  schema "users" do
    field :email, :string
    field :first_name, :string
    field :last_name, :string
    field :is_manager, :boolean, default: false
    field :manager_id, :id
    has_many :tasks, TaskTracker.Tasks.Task

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:first_name, :last_name, :email, :is_manager, :manager_id])
    |> validate_required([:first_name, :last_name, :email])
    |> unique_constraint(:email)
    |> validate_format(:email, ~r/^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$/)
  end
end
