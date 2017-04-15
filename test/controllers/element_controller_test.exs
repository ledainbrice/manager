defmodule Manager.ElementControllerTest do
  use Manager.ConnCase

  alias Manager.Element
  @valid_attrs %{body: "some content", name: "some content"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, element_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    element = Repo.insert! %Element{}
    conn = get conn, element_path(conn, :show, element)
    assert json_response(conn, 200)["data"] == %{"id" => element.id,
      "name" => element.name,
      "body" => element.body,
      "group_id" => element.group_id}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, element_path(conn, :show, "11111111-1111-1111-1111-111111111111")
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, element_path(conn, :create), element: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Element, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, element_path(conn, :create), element: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    element = Repo.insert! %Element{}
    conn = put conn, element_path(conn, :update, element), element: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Element, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    element = Repo.insert! %Element{}
    conn = put conn, element_path(conn, :update, element), element: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    element = Repo.insert! %Element{}
    conn = delete conn, element_path(conn, :delete, element)
    assert response(conn, 204)
    refute Repo.get(Element, element.id)
  end
end
