defmodule Gotham.Owner.Right do
  use Ecto.Schema
  import Ecto.Changeset
  alias Gotham.Accounts.User
  
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "rights" do
    field :name, :string
    has_many :user, User
    timestamps()
  end

  @doc false
  def changeset(right, attrs) do
    right
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
