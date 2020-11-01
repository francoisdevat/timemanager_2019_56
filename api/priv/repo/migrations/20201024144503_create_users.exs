defmodule Gotham.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :email, :string, null: false
      add :firstname, :string, null: false
      add :lastname, :string, null: false
      add :password_hash, :string, null: false
      add :status, :boolean, default: false, null: false
      add :right_id, references(:rights, type: :binary_id), null: false
      add :team_id, references(:teams, type: :binary_id), null: false
      timestamps()
    end

    create unique_index(:users, [:email])

  end
end