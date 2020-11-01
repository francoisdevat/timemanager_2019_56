defmodule Gotham.Repo.Migrations.CreateHours do
  use Ecto.Migration

  def change do
    create table(:hours, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :start, :naive_datetime, null: false
      add :end, :naive_datetime, null: false
      add :user_id, references(:users, type: :binary_id)
      add :team_id, references(:teams, type: :binary_id)
      timestamps()
    end

  end
end
