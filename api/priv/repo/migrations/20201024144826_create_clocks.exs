defmodule Gotham.Repo.Migrations.CreateClocks do
  use Ecto.Migration

  def change do
    create table(:clocks, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :time, :naive_datetime, null: false
      add :status, :boolean, default: false, null: false
      add :user_id, references(:users, type: :binary_id)
      timestamps()
    end

  end
end
