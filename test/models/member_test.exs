defmodule Manager.MemberTest do
  use Manager.ModelCase

  alias Manager.Member

  @valid_attrs %{role: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Member.changeset(%Member{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Member.changeset(%Member{}, @invalid_attrs)
    refute changeset.valid?
  end
end
