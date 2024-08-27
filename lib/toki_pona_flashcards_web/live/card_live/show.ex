defmodule TokiPonaFlashcardsWeb.CardLive.Show do
  use TokiPonaFlashcardsWeb, :live_view

  alias TokiPonaFlashcards.Cards
  alias TokiPonaFlashcards.Accounts

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:user_id, socket.assigns.current_user.id)}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:card, Cards.get_card!(id))}
  end

  defp page_title(:show), do: "Show Card"
  defp page_title(:edit), do: "Edit Card"
end
