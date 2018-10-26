defmodule TaskTracker.Repo.Migrations.NilifyAllManagers do
  use Ecto.Migration

  def change do
    alter table(:users) do
      remove :manager_id
      add :manager_id, references(:users, on_delete: :nilify_all), null: true
    end
  end
end
