defmodule Gotham.Times.Hour do
  use Ecto.Schema
  import Ecto.Changeset
  alias Gotham.Accounts.User
  alias Gotham.Partners.Team
  
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "hours" do
    field :end, :naive_datetime
    field :start, :naive_datetime
    belongs_to :user, Gotham.Accounts.User, foreign_key: :user_id, type: :binary_id
    belongs_to :team, Gotham.Partners.Team, foreign_key: :team_id, type: :binary_id
    timestamps()
  end

  @doc false
  def changeset(hour, attrs) do
    hour
    |> cast(attrs, [:start, :end, :user_id, :team_id])
    |> validate_required([:start, :end])
  end
end
