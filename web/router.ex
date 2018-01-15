defmodule DistanceTracker.Router do
  use DistanceTracker.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api/distance-tracker", DistanceTracker do
    pipe_through :api
    get "/", TrackerController, :index
    get "/:id", TrackerController, :show
  	post "/", TrackerController, :create
  	delete "/:id", TrackerController, :delete
  	patch "/:id", TrackerController, :update
  end
end
