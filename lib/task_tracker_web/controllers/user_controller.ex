defmodule TaskTrackerWeb.UserController do
  use TaskTrackerWeb, :controller

  alias TaskTracker.Users
  alias TaskTracker.Users.User

  def index(conn, _params) do
    users = Users.list_users()
    render(conn, "index.html", users: users)
  end

  def new(conn, _params) do
    changeset = Users.change_user(%User{})
    users = Users.list_users()
    managers = Enum.filter(users, fn u -> u.is_manager end)
    render(conn, "new.html", changeset: changeset, managers: managers)
  end

  def create(conn, %{"user" => user_params}) do
    users = Users.list_users()
    managers = Enum.filter(users, fn u -> u.is_manager end)
    case Users.create_user(user_params) do
      {:ok, user} ->
        conn
        |> put_session(:user_id, user.id)
        |> redirect(to: Routes.task_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset, managers: managers)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Users.get_user!(id)
    manager = Users.get_manager(id)
    underlings = Users.get_underlings(id)
    render(conn, "show.html", user: user, manager: manager, underlings: underlings)
  end

  def edit(conn, %{"id" => id}) do
    user = Users.get_user!(id)
    changeset = Users.change_user(user)
    users = Users.list_users()
    managers = Enum.filter(users, fn u -> u.is_manager and u.id != user.id end)
    render(conn, "edit.html", user: user, changeset: changeset, managers: managers)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Users.get_user!(id)

    case Users.update_user(user, user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User updated successfully.")
        |> redirect(to: Routes.user_path(conn, :show, user))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", user: user, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Users.get_user!(id)
    {:ok, _user} = Users.delete_user(user)

    conn
    |> put_flash(:info, "User deleted successfully.")
    |> redirect(to: Routes.user_path(conn, :index))
  end
end
