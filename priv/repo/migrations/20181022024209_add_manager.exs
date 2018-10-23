defmodule TaskTracker.Repo.Migrations.AddManager do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :manager_id, references(:users), null: true
      add :is_manager, :boolean, default: false, null: false
    end
  end
end
