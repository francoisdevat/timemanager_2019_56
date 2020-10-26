defmodule Gotham.Times.Hour do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "hours" do
    field :end, :naive_datetime
    field :start, :naive_datetime
    belongs_to :user, Gotham.Accounts.User, foreign_key: :user_id, type: :binary_id
    timestamps()
  end

  @doc false
  def changeset(hour, attrs) do
    hour
    |> cast(attrs, [:start, :end])
    |> validate_required([:start, :end])
  end
end
