defmodule Manager.ElementView do
  use Manager.Web, :view

  def render("index.json", %{elements: elements}) do
    %{data: render_many(elements, Manager.ElementView, "element.json")}
  end

  def render("show.json", %{element: element}) do
    %{data: render_one(element, Manager.ElementView, "element.json")}
  end

  def render("element.json", %{element: element}) do
    %{id: element.id,
      name: element.name,
      body: element.body,
      group_id: element.group_id}
  end
end
