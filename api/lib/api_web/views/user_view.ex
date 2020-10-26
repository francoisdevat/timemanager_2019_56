defmodule GothamWeb.UserView do
  use GothamWeb, :view
  alias GothamWeb.UserView

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{id: user.id,
      email: user.email,
      firstname: user.firstname,
      lastname: user.lastname,
      password_hash: user.password_hash,
      status: user.status,
      team_id: user.team_id,
      type: user.type}
  end

    def render("jwt.json", %{jwt: jwt}) do
    %{jwt: jwt}
  end
  
end
