defmodule TodolistWeb.TaskController do
  use TodolistWeb, :controller

  import Ecto
  import Ecto.Query 
  alias Todolist.Repo

  alias Todolist.Account
  alias Todolist.Account.Task
  alias Todolist.Account.User

  action_fallback TodolistWeb.FallbackController

  def index(conn, _params) do
    tasks = Account.list_tasks()
    render(conn, "index.json", tasks: tasks)
  end

  def create(conn, %{"task" => task_params}) do
    with {:ok, %Task{} = task} <- Account.create_task(task_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.task_path(conn, :show, task))
      |> render("show.json", task: task)
    end
  end

  def show(conn, %{"id" => id}) do
    task = Account.get_task!(id)
    render(conn, "show.json", task: task)
  end
  
  def show_user(conn, %{"id" => id}) do
    query = from t in "tasks", where: t.user_id == ^id
    tasks = Repo.all(query)
    render(conn, "indexjson", tasks: tasks)
  end   

  def update(conn, %{"id" => id, "task" => task_params}) do
    task = Account.get_task!(id)

    with {:ok, %Task{} = task} <- Account.update_task(task, task_params) do
      render(conn, "show.json", task: task)
    end
  end

  def delete(conn, %{"id" => id}) do
    task = Account.get_task!(id)

    with {:ok, %Task{}} <- Account.delete_task(task) do
      send_resp(conn, :no_content, "")
    end
  end

end
