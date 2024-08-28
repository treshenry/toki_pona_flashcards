defmodule TokiPonaFlashcardsWeb.PageController do
  use TokiPonaFlashcardsWeb, :controller

  def home(conn, _params) do
    redirect(conn, to: ~p"/cards")
  end
end
