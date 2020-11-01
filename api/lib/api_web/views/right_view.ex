defmodule GothamWeb.RightView do
  use GothamWeb, :view
  alias GothamWeb.RightView

  def render("index.json", %{rights: rights}) do
    %{data: render_many(rights, RightView, "right.json")}
  end

  def render("show.json", %{right: right}) do
    %{data: render_one(right, RightView, "right.json")}
  end

  def render("right.json", %{right: right}) do
    %{id: right.id,
      name: right.name}
  end
end
