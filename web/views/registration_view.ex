defmodule DistanceTracker.RegistrationView do
  use DistanceTracker.Web, :view

  def render("success.json", %{user: user}) do
    %{
      status: :ok,
      message: """
        Now you can sign in using your email and password at /api/v1/sign_in. You will receive JWT token.
        Please put this token into Authorization header for all authorized requests.
      """
    }
  end
end