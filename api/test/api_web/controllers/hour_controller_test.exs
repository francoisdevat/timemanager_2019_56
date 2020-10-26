defmodule GothamWeb.HourControllerTest do
  use GothamWeb.ConnCase

  alias Gotham.Times
  alias Gotham.Times.Hour

  @create_attrs %{
    end: ~N[2010-04-17 14:00:00],
    start: ~N[2010-04-17 14:00:00]
  }
  @update_attrs %{
    end: ~N[2011-05-18 15:01:01],
    start: ~N[2011-05-18 15:01:01]
  }
  @invalid_attrs %{end: nil, start: nil}

  def fixture(:hour) do
    {:ok, hour} = Times.create_hour(@create_attrs)
    hour
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all hours", %{conn: conn} do
      conn = get(conn, Routes.hour_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create hour" do
    test "renders hour when data is valid", %{conn: conn} do
      conn = post(conn, Routes.hour_path(conn, :create), hour: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.hour_path(conn, :show, id))

      assert %{
               "id" => id,
               "end" => "2010-04-17T14:00:00",
               "start" => "2010-04-17T14:00:00"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.hour_path(conn, :create), hour: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update hour" do
    setup [:create_hour]

    test "renders hour when data is valid", %{conn: conn, hour: %Hour{id: id} = hour} do
      conn = put(conn, Routes.hour_path(conn, :update, hour), hour: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.hour_path(conn, :show, id))

      assert %{
               "id" => id,
               "end" => "2011-05-18T15:01:01",
               "start" => "2011-05-18T15:01:01"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, hour: hour} do
      conn = put(conn, Routes.hour_path(conn, :update, hour), hour: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete hour" do
    setup [:create_hour]

    test "deletes chosen hour", %{conn: conn, hour: hour} do
      conn = delete(conn, Routes.hour_path(conn, :delete, hour))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.hour_path(conn, :show, hour))
      end
    end
  end

  defp create_hour(_) do
    hour = fixture(:hour)
    %{hour: hour}
  end
end
