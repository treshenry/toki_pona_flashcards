defmodule TokiPonaFlashcardsWeb.StudyLive.Index do
  use TokiPonaFlashcardsWeb, :live_view

  @impl true
  def render(assigns) do
    ~H"""
    <div>oh hi</div>
    """
  end

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end
end
