defmodule LRTF.PageController do
  use LRTF.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
