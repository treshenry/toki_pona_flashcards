defmodule TokiPonaFlashcardsWeb.PageController do
  use TokiPonaFlashcardsWeb, :controller

  def home(conn, _params) do
    render(conn, :home, layout: false)
  end
end
