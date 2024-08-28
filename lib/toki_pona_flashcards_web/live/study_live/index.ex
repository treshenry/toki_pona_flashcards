defmodule TokiPonaFlashcardsWeb.StudyLive.Index do
  alias TokiPonaFlashcards.Cards

  use TokiPonaFlashcardsWeb, :live_view

  @impl true
  def render(assigns) do
    ~H"""
    <div class="text-2xl">This is study session #<%= @current_session %></div>
    <div class="text-xl">This is card <%= @current_card_index + 1 %> of <%= length(@cards) %></div>
    """
  end

  @impl true
  def mount(_params, _session, socket) do
    current_session = socket.assigns.current_user.study_session

    {:ok,
     socket
     |> assign(:current_session, current_session)
     |> assign(:cards, Cards.get_cards_for_session(socket.assigns.current_user, current_session))
     |> assign(:current_card_index, 0)}
  end
end
