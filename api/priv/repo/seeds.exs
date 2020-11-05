# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Gotham.Repo.insert!(%Gotham.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias Gotham.Repo
alias Gotham.Accounts.User
alias Gotham.Partners.Team
alias Gotham.Owner.Right
alias Gotham.Pointers.Clock
alias Gotham.Times.Hour

right_data = [
    %{
        name: "employee"
    },
    %{
        name: "manager"
    },
    %{
        name: "generalmanager"
    }
]

Enum.each(right_data, fn(data) ->
  Gotham.Owner.create_right(data)
end)

team_data = [
    %{
        name: "Team Phoenix"
    },
    %{
        name: "Team Epitech"
    },
    %{
        name: "Employee"
    },
    %{
        name: "Manager"
    },
    %{
        name: "General Manager"
    }
]

Enum.each(team_data, fn(data) ->
  Gotham.Partners.create_team(data)
end)