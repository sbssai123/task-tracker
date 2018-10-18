defmodule TaskTracker.Repo.Migrations.AddFieldsToTasks do
  use Ecto.Migration

  def change do
    alter table(:tasks) do
      add :user_id, references(:users, on_delete: :nothing)
    end
  end
end
