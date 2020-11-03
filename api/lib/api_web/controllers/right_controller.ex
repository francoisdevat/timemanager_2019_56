defmodule GothamWeb.RightController do
  use GothamWeb, :controller

  alias Gotham.Owner
  alias Gotham.Owner.Right

  action_fallback GothamWeb.FallbackController

  def index(conn, _params) do
    rights = Owner.list_rights()
    render(conn, "index.json", rights: rights)
  end

  def create(conn, %{"right" => right_params}) do
    with {:ok, %Right{} = right} <- Owner.create_right(right_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.right_path(conn, :show, right))
      |> render("show.json", right: right)
    end
  end

  def show(conn, %{"id" => id}) do
    right = Owner.get_right!(id)
    render(conn, "show.json", right: right)
  end

  def update(conn, %{"id" => id, "right" => right_params}) do
    right = Owner.get_right!(id)

    with {:ok, %Right{} = right} <- Owner.update_right(right, right_params) do
      render(conn, "show.json", right: right)
    end
  end

  def delete(conn, %{"id" => id}) do
    right = Owner.get_right!(id)

    with {:ok, %Right{}} <- Owner.delete_right(right) do
      send_resp(conn, :no_content, "")
    end
  end
end
