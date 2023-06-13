defmodule OsuuspuutarhaWeb.PageController do
  use OsuuspuutarhaWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def privacy(conn, _params) do
    render(conn, "privacy.html")
  end

  def organic(conn, _params) do
    render(conn, "organic.html")
  end
end
