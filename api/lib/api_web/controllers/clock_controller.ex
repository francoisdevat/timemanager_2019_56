defmodule GothamWeb.ClockController do
  use GothamWeb, :controller

  alias Gotham.Pointers
  alias Gotham.Pointers.Clock

  action_fallback GothamWeb.FallbackController

  def index(conn, _params) do
    clocks = Pointers.list_clocks()
    render(conn, "index.json", clocks: clocks)
  end

  def create(conn, %{"clock" => clock_params}) do
    with {:ok, %Clock{} = clock} <- Pointers.create_clock(clock_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.clock_path(conn, :show, clock))
      |> render("show.json", clock: clock)
    end
  end

  def show(conn, %{"id" => id}) do
    clock = Pointers.get_clock!(id)
    render(conn, "show.json", clock: clock)
  end

  def clockbyteamid(conn, %{"team_id" => team_id}) do
    clock = Pointers.get_clockbyteamid!(team_id)
    render(conn, "show.json", clock: clock)
  end

  def update(conn, %{"id" => id, "clock" => clock_params}) do
    clock = Pointers.get_clock!(id)

    with {:ok, %Clock{} = clock} <- Pointers.update_clock(clock, clock_params) do
      render(conn, "show.json", clock: clock)
    end
  end

  def delete(conn, %{"id" => id}) do
    clock = Pointers.get_clock!(id)

    with {:ok, %Clock{}} <- Pointers.delete_clock(clock) do
      send_resp(conn, :no_content, "")
    end
  end
end
