defmodule Manager.ElementTest do
  use Manager.ModelCase

  alias Manager.Element

  @valid_attrs %{body: "some content", name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Element.changeset(%Element{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Element.changeset(%Element{}, @invalid_attrs)
    refute changeset.valid?
  end
end
