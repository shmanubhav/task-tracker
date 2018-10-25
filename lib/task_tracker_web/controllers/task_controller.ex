defmodule TaskTrackerWeb.TaskController do
  use TaskTrackerWeb, :controller

  alias TaskTracker.Tasks
  alias TaskTracker.Tasks.Task
  alias TaskTracker.Users
  alias TaskTracker.TimeBlocks
  alias TaskTracker.TimeBlocks.TimeBlock

  def index(conn, _params) do
    tasks = Tasks.list_tasks()
    user_id = get_session(conn, :user_id)
    mytasks = Tasks.get_tasks_for_user(user_id)
    unassignedtasks = Tasks.get_unassigned_tasks
    render(conn, "index.html", tasks: tasks, mytasks: mytasks, unassignedtasks: unassignedtasks)
  end

  def new(conn, _params) do
    changeset = Tasks.change_task(%Task{})
    users = Users.list_users
    render(conn, "new.html", users: users, changeset: changeset)
  end

  def create(conn, %{"task" => task_params}) do
    case Tasks.create_task(task_params) do
      {:ok, task} ->
        conn
        |> put_flash(:info, "Task created successfully.")
        |> redirect(to: Routes.task_path(conn, :show, task))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    task = Tasks.get_task!(id)
    users = Users.list_users
    render(conn, "show.html", task: task, users: users)
  end

  def edit(conn, %{"id" => id}) do
    task = Tasks.get_task!(id)
    changeset = Tasks.change_task(task)
    users = Users.list_users
    render(conn, "edit.html", task: task, changeset: changeset, users: users)
  end

  def update(conn, %{"id" => id, "task" => task_params}) do
    task = Tasks.get_task!(id)
    timeblock = TimeBlocks.get_timeblock_for_taskid(id)
    if (timeblock == nil) do
      case TimeBlocks.create_time_block(%{task_id: id}) do
        {:ok, timeblock} ->
          conn
          |> put_flash(:info, "Timeblock created for this task.")

        {:error, _ret} ->
          conn
          |> put_flash(:info, "Timeblock creation error.")
      end
    end
    time_in = get_naive_date(task_params[:timeblock][:start])
    time_out = get_naive_date(task_params[:timeblock][:end])
    timeblock = TimeBlocks.change_time_block(%TimeBlock{task_id: id, start: time_in, end: time_out})
    IO.inspect(task_params)
    # task_params = %{task_params | timeblock: timeblock}
    Map.put(task_params, :timeblock, timeblock)
    IO.inspect(task_params)
    case Tasks.update_task(task, task_params) do
      {:ok, task} ->
        conn
        |> put_flash(:info, "Task updated successfully.")
        |> redirect(to: Routes.task_path(conn, :show, task))

      {:error, %Ecto.Changeset{} = changeset} ->
        users = Users.list_users
        render(conn, "edit.html", users: users, task: task, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    task = Tasks.get_task!(id)
    {:ok, _task} = Tasks.delete_task(task)

    conn
    |> put_flash(:info, "Task deleted successfully.")
    |> redirect(to: Routes.task_path(conn, :index))
  end

  def get_naive_date(date_params) do
    case NaiveDateTime.new(date_params[:year], date_params[:month], date_params[:day], date_params[:hour], date_params[:minute], 0) do
      {:ok, naivedate} ->
        naivedate
      _ ->
        {:error}
    end
  end
end
