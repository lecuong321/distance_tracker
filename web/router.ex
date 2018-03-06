defmodule DistanceTracker.Router do
  use DistanceTracker.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/swagger" do
    forward "/", PhoenixSwagger.Plug.SwaggerUI,
      otp_app: :distance_tracker,
      swagger_file: "swagger.json",
      disable_validator: true
  end
  
  scope "/api/distance-tracker", DistanceTracker do
    pipe_through :api
    get "/", TrackerController, :index
    get "/:id", TrackerController, :show
  	post "/", TrackerController, :create
  	delete "/:id", TrackerController, :delete
  	patch "/:id", TrackerController, :update
  end

  def swagger_info do
    %{    
      info: %{
        version: "1.0",
        title: "Distance Tracker",
        host: "localhost:4000"
      }
    }
  end

  resources "/users", UserController
end
