defmodule TokiPonaFlashcards.CardsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `TokiPonaFlashcards.Cards` context.
  """

  @doc """
  Generate a card.
  """
  def card_fixture(attrs \\ %{}) do
    {:ok, card} =
      attrs
      |> Enum.into(%{
        back: "some back",
        back_sitelen: true,
        front: "some front",
        front_sitelen: true
      })
      |> TokiPonaFlashcards.Cards.create_card()

    card
  end
end
