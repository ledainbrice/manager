defmodule Manager.UserView do
  use Manager.Web, :view

  def render("index.json", %{users: users}) do
    %{data: render_many(users, Manager.UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, Manager.UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{id: user.id,
      email: user.email,
      name: user.name}
  end
end
