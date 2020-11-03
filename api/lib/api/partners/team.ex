defmodule Gotham.Partners.Team do
  use Ecto.Schema
  import Ecto.Changeset
  alias Gotham.Accounts.User
  alias Gotham.Times.Hour

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "teams" do
    field :name, :string
    has_many :user, User
    has_many :hour, Hour
    timestamps()
  end

  @doc false
  def changeset(team, attrs) do
    team
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
