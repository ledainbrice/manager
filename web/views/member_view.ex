defmodule Manager.MemberView do
  use Manager.Web, :view


  def render("member.json", %{member: member}) do
    %{id: member.id,
      role: member.role,
      user: render_one(member.user, Manager.UserView, "user.json")}
  end
end
