defmodule DistanceTracker.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias DistanceTracker.Repo
  alias DistanceTracker.Users.User

  schema "users" do
    field :email, :string
    field :is_admin, :boolean, default: false
    field :name, :string
    field :password, :string, virtual: true # We need to add this row
    field :password_hash, :string
    field :phone, :string

    timestamps()
  end

  @doc false
  #def changeset(%User{} = user, attrs) do
  #  user
  #  |> cast(attrs, [:email, :name, :phone, :password_hash, :is_admin])
  #  |> validate_required([:email, :name, :phone, :password_hash, :is_admin])
  #end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:email, :name, :phone, :password, :is_admin])
    |> validate_required([:email, :name, :password])
    |> validate_changeset
  end

  def registration_changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:email, :name, :phone, :password])
    |> validate_required([:email, :name, :phone, :password])
    |> validate_changeset
  end

  defp validate_changeset(struct) do
    struct
    |> validate_length(:email, min: 5, max: 255)
    |> validate_format(:email, ~r/@/)
    |> unique_constraint(:email)
    |> validate_length(:password, min: 8)
    |> validate_format(:password, ~r/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).*/, [message: "Must include at least one lowercase letter, one uppercase letter, and one digit"])
    |> generate_password_hash
  end

  defp generate_password_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: password}} ->
        put_change(changeset, :password_hash, Comeonin.Bcrypt.hashpwsalt(password))
      _ ->
        changeset
    end
  end

  def find_and_confirm_password(email, password) do
    case Repo.get_by(User, email: email) do
      nil ->
        {:error, :not_found}
      user ->
        if Comeonin.Bcrypt.checkpw(password, user.password_hash) do
          {:ok, user}
        else
          {:error, :unauthorized}
        end
    end
  end

end
