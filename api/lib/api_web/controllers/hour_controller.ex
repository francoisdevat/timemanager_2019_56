defmodule GothamWeb.HourController do
  use GothamWeb, :controller

  alias Gotham.Times
  alias Gotham.Times.Hour
  require Logger
  action_fallback GothamWeb.FallbackController

  def index(conn, _params) do
    hours = Times.list_hours()
    render(conn, "index.json", hours: hours)
  end

  def create(conn, %{"hour" => hour_params}) do
    with {:ok, %Hour{} = hour} <- Times.create_hour(hour_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.hour_path(conn, :show, hour))
      |> render("show.json", hour: hour)
    end
  end

  def show(conn, %{"id" => id}) do
    hour = Times.get_hour!(id)
    render(conn, "show.json", hour: hour)
  end

  def hourbytime(conn, %{"start" => start, "end" => endtime}) do
      hours = Times.get_hourbytime!(start, endtime)
      render(conn, "index.json", hours: hours)
  end

  def hourbyuser(conn, %{"user_id" => user_id}) do
    hours = Times.get_hourbyuser!(user_id)
    render(conn, "index.json", hours: hours)
  end

  def hourbyteam(conn, %{"team_id" => team_id}) do
    hours = Times.get_hourbyteam!(team_id)
    render(conn, "index.json", hours: hours)
  end

  def update(conn, %{"id" => id, "hour" => hour_params}) do
    hour = Times.get_hour!(id)

    with {:ok, %Hour{} = hour} <- Times.update_hour(hour, hour_params) do
      render(conn, "show.json", hour: hour)
    end
  end

  def delete(conn, %{"id" => id}) do
    hour = Times.get_hour!(id)

    with {:ok, %Hour{}} <- Times.delete_hour(hour) do
      send_resp(conn, :no_content, "")
    end
  end
end
