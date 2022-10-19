defmodule AdminDashboardWeb.PageController do
  use AdminDashboardWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
