defmodule Manager.ElementView do
  use Manager.Web, :view

  def render("index.json", %{elements: elements}) do
    %{data: render_many(elements, Manager.ElementView, "element.json")}
  end

  def render("show.json", %{element: element}) do
    %{data: render_one(element, Manager.ElementView, "element.json")}
  end

  def render("element.json", %{element: element} = %{element: %{id: id, children: children} }) when is_list(children) do
    IO.inspect element
    %{id: element.id,
      name: element.name,
      body: element.body,
      group_id: element.group_id,
      parent: element.element_id,
      children: render_many(element.children, Manager.ElementView, "element.json")
    }
  end

  def render("element.json", %{element: element}) do
    %{id: element.id,
      name: element.name,
      body: element.body,
      group_id: element.group_id,
      parent: element.element_id
    }
  end
end
