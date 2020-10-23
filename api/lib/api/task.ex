defmodule Todolist.Task do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tasks" do
    field :description, :string, null: false
    field :staus, :boolean, default: false
    field :title, :string, null: false
    belongs_to :user_id, Todolist.User 

    timestamps()
  end

  @doc false
  def changeset(task, attrs) do
    task
    |> cast(attrs, [:title, :description, :staus, :user_id])
    |> validate_required([:title, :description, :staus, :user_id])
  end
end
