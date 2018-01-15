defmodule DistanceTracker.Repo.Migrations.CreateDistanceTracker do
  use Ecto.Migration

  def change do
    create table(:distance_tracker, primary_key: true) do
    	add :uuid, :uuid, primary_key: true
    	add :distance, :integer
    	add :activity, :string
    	add :completed_at, :utc_datetime

    	timestamps()
    end
  end
end
