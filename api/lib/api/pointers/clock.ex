defmodule Gotham.Pointers.Clock do
  use Ecto.Schema
  import Ecto.Changeset
  alias Gotham.Accounts.User
  
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "clocks" do
    field :status, :boolean, default: false
    field :time, :naive_datetime
    belongs_to :user, Gotham.Accounts.User, foreign_key: :user_id, type: :binary_id
    timestamps()
  end

  @doc false
  def changeset(clock, attrs) do
    clock
    |> cast(attrs, [:time, :status, :user_id])
    |> validate_required([:time, :status])
  end
end
