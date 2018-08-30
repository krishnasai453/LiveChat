defmodule Messaging.PageController do
  use Messaging.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
