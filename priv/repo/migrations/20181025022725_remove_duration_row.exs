defmodule TaskTracker.Repo.Migrations.RemoveDurationRow do
  use Ecto.Migration

  def change do
    alter table(:tasks) do
      remove :duration
    end
  end
end
