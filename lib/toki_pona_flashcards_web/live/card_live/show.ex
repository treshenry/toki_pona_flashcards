defmodule TokiPonaFlashcardsWeb.CardLive.Show do
  use TokiPonaFlashcardsWeb, :live_view

  alias TokiPonaFlashcards.Cards

  @impl true
  def render(assigns) do
    ~H"""
    <.header>
      Card #<%= @card.id %>
      <:actions>
        <span class="text-violet-100 hover:text-violet-300 cursor-pointer pr-3" phx-click="reset">
          <.icon name="hero-arrow-path-rounded-square" />
        </span>
        <.link patch={~p"/cards/#{@card}/show/edit"} phx-click={JS.push_focus()}>
          <span class="text-violet-100 hover:text-violet-300 pr-3">
            <.icon name="hero-pencil-square" />
          </span>
        </.link>
        <.link phx-click={JS.push("delete", value: %{id: @card.id})} data-confirm="Are you sure?">
          <span class="text-violet-100 hover:text-violet-300">
            <.icon name="hero-trash" />
          </span>
        </.link>
      </:actions>
    </.header>

    <.list>
      <:item title="Front">
        <span class={[@card.front_sitelen == true && "font-sitelen text-4xl"]}>
          <%= @card.front %>
        </span>
      </:item>
      <:item title="Back"><%= @card.back %></:item>
      <:item title="Review in"><%= Cards.get_review_sessions_label(@card) %></:item>
    </.list>

    <.back navigate={~p"/cards"}>Back to cards</.back>

    <.modal :if={@live_action == :edit} id="card-modal" show on_cancel={JS.patch(~p"/cards/#{@card}")}>
      <.live_component
        module={TokiPonaFlashcardsWeb.CardLive.FormComponent}
        id={@card.id}
        user_id={@user_id}
        title={@page_title}
        action={@live_action}
        card={@card}
        patch={~p"/cards/#{@card}"}
      />
    </.modal>
    """
  end

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

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    card = Cards.get_card!(id)
    {:ok, _} = Cards.delete_card(card)

    {:noreply,
     socket
     |> push_navigate(to: ~p"/cards")
     |> put_flash(:info, "Card deleted")}
  end

  def handle_event("reset", _, socket) do
    {:ok, card} = Cards.update_card(socket.assigns.card, %{box: 0})

    {:noreply, socket |> assign(:card, card)}
  end

  defp page_title(:show), do: "Show Card"
  defp page_title(:edit), do: "Edit Card"
end
