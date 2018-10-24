defmodule TaskTracker.Repo.Migrations.AlterTimeType do
  use Ecto.Migration

  def change do
    alter table(:timeblocks) do
      remove :start_time
      remove :end_time
      add :start_time, :naive_datetime
      add :end_time, :naive_datetime
    end
  end
end
