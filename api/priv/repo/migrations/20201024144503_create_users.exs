defmodule Gotham.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :email, :string
      add :firstname, :string
      add :lastname, :string
      add :password_hash, :string
      add :status, :boolean, default: false, null: false
      add :type, :string
      add :team_id, references(:teams, type: :binary_id)
      timestamps()
    end

    create unique_index(:users, [:email])

  end
end