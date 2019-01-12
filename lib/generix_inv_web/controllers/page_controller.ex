defmodule GenerixInvWeb.PageController do
  use GenerixInvWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
