defmodule Todolist.Account.Task do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tasks" do
    field :description, :string
    field :staus, :boolean, default: false
    field :title, :string
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(task, attrs) do
    task
    |> cast(attrs, [:title, :description, :staus])
    |> validate_required([:title, :description, :staus])
  end
end
