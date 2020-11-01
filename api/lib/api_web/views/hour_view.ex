defmodule GothamWeb.HourView do
  use GothamWeb, :view
  alias GothamWeb.HourView

  def render("index.json", %{hours: hours}) do
    %{data: render_many(hours, HourView, "hour.json")}
  end

  def render("show.json", %{hour: hour}) do
    %{data: render_one(hour, HourView, "hour.json")}
  end

  def render("hour.json", %{hour: hour}) do
    %{id: hour.id,
      start: hour.start,
      end: hour.end,
      user_id: hour.user_id,
      team_id: hour.team_id}
  end
end
