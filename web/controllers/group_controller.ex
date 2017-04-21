defmodule Manager.GroupController do
  use Manager.Web, :controller

  alias Manager.Group

  def index(conn, _params) do
    groups = Repo.all(Group)
    render(conn, "index.json", groups: groups)
  end

  def create(conn, %{"group" => group_params,"user_id" => user_id }) do

    group_params = Map.merge(group_params,%{"members" => [%{"user_id" => user_id, "role" => "admin"}]})
    changeset = Group.changeset(%Group{}, group_params)
    case Repo.insert(changeset) do
      {:ok, group} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", group_path(conn, :show, group))
        |> render("show.json", group: group)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Manager.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    group = Repo.get!(Group, id)|> Repo.preload(members: :user)
    render(conn, "show.json", group: group)
  end

  def update(conn, %{"id" => id, "group" => group_params}) do
    group = Repo.get!(Group, id)
    changeset = Group.changeset(group, group_params)

    case Repo.update(changeset) do
      {:ok, group} ->
        render(conn, "show.json", group: group)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Manager.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    group = Repo.get!(Group, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(group)

    send_resp(conn, :no_content, "")
  end

  def invited(conn, %{"id" => id,"user_id" => user_id}) do
    group = Repo.get!(Group, id)
    user = Repo.get!(Manager.User, user_id)
    changeset = Manager.Member.changeset(%Manager.Member{},%{"role" => "invited","user_id" => user_id,"group_id" => id})
    case Repo.insert(changeset) do
      {:ok, member} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", group_path(conn, :show, group))
        |> render("show.json", group: group)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Manager.ChangesetView, "error.json", changeset: changeset)
    end
  end
end
