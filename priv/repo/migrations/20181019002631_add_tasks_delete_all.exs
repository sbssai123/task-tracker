defmodule TaskTracker.Repo.Migrations.AddTasksDeleteAll do
  use Ecto.Migration

  def change do
    alter table(:tasks) do
      remove :user_id
      add :user_id, references(:users, on_delete: :delete_all)
    end
  end
end
