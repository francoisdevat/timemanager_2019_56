defmodule Gotham.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Gotham.Partners.Team
  alias Gotham.Owner.Right
  alias Gotham.Pointers.Clock
  alias Gotham.Times.Hour

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "users" do
    field :email, :string
    field :firstname, :string
    field :lastname, :string
    field :password_hash, :string
    field :status, :boolean, default: false
    belongs_to :team, Team, foreign_key: :team_id, type: :binary_id
    belongs_to :right, Right, foreign_key: :right_id, type: :binary_id
    field :password, :string, virtual: true
    has_many :clock, Clock
    has_many :hour, Hour
    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :firstname, :lastname, :password, :status, :team_id, :right_id])
    |> validate_required([:email, :firstname, :lastname, :password, :status])
    |> validate_format(:email, ~r/@/)
    |> unique_constraint(:email)
    |> put_password_hash
  end

  defp put_password_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: password}}
        ->
          put_change(changeset, :password_hash, Pbkdf2.hash_pwd_salt(password))
      _ ->
          changeset
    end
  end

end
