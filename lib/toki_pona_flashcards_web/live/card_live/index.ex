defmodule TokiPonaFlashcardsWeb.CardLive.Index do
  use TokiPonaFlashcardsWeb, :live_view

  alias TokiPonaFlashcards.Accounts
  alias TokiPonaFlashcards.Cards
  alias TokiPonaFlashcards.Cards.Card

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:user_id, socket.assigns.current_user.id)
     |> stream(:cards, Cards.list_cards())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Card")
    |> assign(:card, Cards.get_card!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Card")
    |> assign(:card, %Card{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Cards")
    |> assign(:card, nil)
  end

  defp bool_label(val) do
    if val do
      "✅"
    else
      "❌"
    end
  end

  @impl true
  def handle_info({TokiPonaFlashcardsWeb.CardLive.FormComponent, {:saved, card}}, socket) do
    {:noreply, stream_insert(socket, :cards, card)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    card = Cards.get_card!(id)
    {:ok, _} = Cards.delete_card(card)

    {:noreply, stream_delete(socket, :cards, card)}
  end
end
