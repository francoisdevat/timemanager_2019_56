defmodule GothamWeb.RightControllerTest do
  use GothamWeb.ConnCase

  alias Gotham.Owner
  alias Gotham.Owner.Right

  @create_attrs %{
    name: "some name"
  }
  @update_attrs %{
    name: "some updated name"
  }
  @invalid_attrs %{name: nil}

  def fixture(:right) do
    {:ok, right} = Owner.create_right(@create_attrs)
    right
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all rights", %{conn: conn} do
      conn = get(conn, Routes.right_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create right" do
    test "renders right when data is valid", %{conn: conn} do
      conn = post(conn, Routes.right_path(conn, :create), right: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.right_path(conn, :show, id))

      assert %{
               "id" => id,
               "name" => "some name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.right_path(conn, :create), right: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update right" do
    setup [:create_right]

    test "renders right when data is valid", %{conn: conn, right: %Right{id: id} = right} do
      conn = put(conn, Routes.right_path(conn, :update, right), right: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.right_path(conn, :show, id))

      assert %{
               "id" => id,
               "name" => "some updated name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, right: right} do
      conn = put(conn, Routes.right_path(conn, :update, right), right: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete right" do
    setup [:create_right]

    test "deletes chosen right", %{conn: conn, right: right} do
      conn = delete(conn, Routes.right_path(conn, :delete, right))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.right_path(conn, :show, right))
      end
    end
  end

  defp create_right(_) do
    right = fixture(:right)
    %{right: right}
  end
end
