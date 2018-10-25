defmodule TaskTrackerWeb.TaskController do
  use TaskTrackerWeb, :controller

  alias TaskTracker.Tasks
  alias TaskTracker.Tasks.Task
  alias TaskTracker.Users
  alias TaskTracker.Timeblocks

  def index(conn, _params) do
    tasks = Tasks.list_tasks()
    current_user = get_session(conn, :user_id)
    your_tasks = Tasks.get_user_tasks(current_user)
    underling_tasks = Tasks.get_underling_tasks(current_user)
    unassigned_tasks = Tasks.get_unassigned_tasks()
    render(conn, "index.html", tasks: your_tasks, underling_tasks: underling_tasks,
    unassigned_tasks: unassigned_tasks)
  end

  def new(conn, _params) do
    current_user = get_session(conn, :user_id)
    changeset = Tasks.change_task(%Task{})
    cu = Users.get_user(current_user)
    users = Users.get_underlings(current_user) ++ [cu]
    render(conn, "new.html", changeset: changeset, users: users)
  end

  def create(conn, %{"task" => task_params}) do
    current_user = get_session(conn, :user_id)
    users = Users.get_underlings(current_user)
    case Tasks.create_task(task_params) do
      {:ok, task} ->
        conn
        |> put_flash(:info, "Task created successfully.")
        |> redirect(to: Routes.task_path(conn, :show, task))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset, users: users)
    end
  end

  def show(conn, %{"id" => id}) do
    task = Tasks.get_task!(id)
    timeblocks = Timeblocks.get_timeblock_for_task(task.id)
    if task.user_id do
      user = Users.get_user!(task.user_id)
      render(conn, "show.html", task: task, user: user, timeblocks: timeblocks)
    else
      user = nil
      render(conn, "show.html", task: task, user: user, timeblocks: timeblocks)
    end
  end

  def edit(conn, %{"id" => id}) do
    task = Tasks.get_task!(id)
    changeset = Tasks.change_task(task)
    current_user = get_session(conn, :user_id)
    cu = Users.get_user(current_user)
    users = Users.get_underlings(current_user) ++ [cu]
    render(conn, "edit.html", task: task, users: users, changeset: changeset)
  end

  def update(conn, %{"id" => id, "task" => task_params}) do
    task = Tasks.get_task!(id)
    current_user = get_session(conn, :user_id)
    cu = Users.get_user(current_user)
    users = Users.get_underlings(current_user) ++ [cu]
    case Tasks.update_task(task, task_params) do
      {:ok, task} ->
        conn
        |> put_flash(:info, "Task updated successfully.")
        |> redirect(to: Routes.task_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", task: task, changeset: changeset, users: users)
    end
  end

  def delete(conn, %{"id" => id}) do
    task = Tasks.get_task!(id)
    {:ok, _task} = Tasks.delete_task(task)

    conn
    |> put_flash(:info, "Task deleted successfully.")
    |> redirect(to: Routes.task_path(conn, :index))
  end
end
