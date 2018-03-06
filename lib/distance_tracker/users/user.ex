defmodule DistanceTracker.Users.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias DistanceTracker.Users.User


  schema "users" do
    field :email, :string
    field :is_admin, :boolean, default: false
    field :name, :string
    field :password_hash, :string
    field :phone, :string

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:email, :name, :phone, :password_hash, :is_admin])
    |> validate_required([:email, :name, :phone, :password_hash, :is_admin])
  end
end
