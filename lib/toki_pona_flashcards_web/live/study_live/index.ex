defmodule TokiPonaFlashcardsWeb.StudyLive.Index do
  alias TokiPonaFlashcards.Cards

  use TokiPonaFlashcardsWeb, :live_view

  @impl true
  def render(assigns) do
    ~H"""
    <div class="text-2xl text-violet-50">This is study session #<%= @current_session %></div>
    <div class="text-xl text-violet-50">
      This is card <%= @current_card_index + 1 %> of <%= length(@cards) %>
    </div>
    <.card>
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
        <.button phx-click="flip_card"><.icon name="hero-arrows-right-left" /></.button>
      <% else %>
        <.button phx-click="good" class="bg-teal-900 hover:bg-teal-800">
          <.icon name="hero-check-badge" />
        </.button>
        <.button phx-click="bad" class="bg-red-800 hover:bg-red-900">
          <.icon name="hero-x-circle" />
        </.button>
      <% end %>
    </div>
    """
  end

  @impl true
  def mount(_params, _session, socket) do
    current_session = socket.assigns.current_user.study_session
    cards = Cards.get_cards_for_session(socket.assigns.current_user, current_session)

    {:ok,
     socket
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
    {:noreply, socket}
  end

  def handle_event("bad", _, socket) do
    {:noreply, socket}
  end
end
