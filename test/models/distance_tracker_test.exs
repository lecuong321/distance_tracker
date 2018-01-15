defmodule DistanceTracker.DistanceTrackerTest do
  use DistanceTracker.ModelCase

  alias DistanceTracker.DistanceTracker

  @valid_attrs %{activity: "some activity", completed_at: "2010-04-17 14:00:00.000000Z", distance: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = DistanceTracker.changeset(%DistanceTracker{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = DistanceTracker.changeset(%DistanceTracker{}, @invalid_attrs)
    refute changeset.valid?
  end
end
