defmodule TokiPonaFlashcardsWeb.StudyLive.Index do
  alias TokiPonaFlashcards.Cards

  use TokiPonaFlashcardsWeb, :live_view

  @impl true
  def render(assigns) do
    ~H"""
    <div class="text-2xl text-violet-50 mb-4">This is study session #<%= @current_session %></div>
    <%= if length(@cards) > 0 do %>
      <div class="text-xl text-violet-50">
        This is card <%= @current_card_index + 1 %> of <%= length(@cards) %>
      </div>
      <.card side={@side}>
        <%= if @side == :front do %>
          <div class={if @current_card.front_sitelen, do: "font-sitelen"}>
            <%= @current_card.front %>
          </div>
        <% else %>
          <%= @current_card.back %>
        <% end %>
      </.card>

      <div class="flex justify-center space-x-3">
        <%= if @side == :front do %>
          <.button phx-click="flip_card" class="bg-violet-900 hover:bg-violet-800">
            <.icon name="hero-arrows-right-left" />
          </.button>
        <% else %>
          <.button phx-click="good" class="bg-teal-900 hover:bg-teal-800">
            <.icon name="hero-check-badge" />
          </.button>
          <.button phx-click="bad" class="bg-red-900 hover:bg-red-800">
            <.icon name="hero-x-circle" />
          </.button>
        <% end %>
      </div>
    <% else %>
      <div class="text-xl text-white mb-4">There are no cards for this session</div>
      <.link class="text-violet-200" navigate={~p"/cards"}>
        <.icon name="hero-arrow-left" /> Back to cards
      </.link>
    <% end %>
    """
  end

  @impl true
  def mount(_params, _session, socket) do
    current_session = socket.assigns.current_user.study_session
    cards = Cards.get_cards_for_session(socket.assigns.current_user, current_session)

    {:ok,
     socket
     |> assign(:page_title, "Study")
     |> assign(:current_session, current_session)
     |> assign(:cards, cards)
     |> assign(:current_card_index, 0)
     |> assign(:current_card, cards |> Enum.at(0))
     |> assign(:side, :front)}
  end

  @impl true
  def handle_event("flip_card", _, socket) do
    {:noreply, socket |> assign(:side, :back)}
  end

  def handle_event("good", _, socket) do
    Cards.good(socket.assigns.current_card, socket.assigns.current_session)

    {:noreply, socket |> next_card_or_done()}
  end

  def handle_event("bad", _, socket) do
    Cards.bad(socket.assigns.current_card)

    {:noreply, socket |> next_card_or_done()}
  end

  defp next_card_or_done(socket) do
    card_index = socket.assigns.current_card_index + 1

    if card_index >= length(socket.assigns.cards) do
      socket
      |> push_navigate(to: ~p"/cards")
    else
      socket
      |> assign(:current_card_index, card_index)
      |> assign(:current_card, socket.assigns.cards |> Enum.at(card_index))
      |> assign(:side, :front)
    end
  end
end
