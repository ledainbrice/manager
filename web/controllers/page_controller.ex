defmodule Manager.PageController do
  use Manager.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
