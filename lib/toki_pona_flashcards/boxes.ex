defmodule TokiPonaFlashcards.Boxes do
  alias TokiPonaFlashcards.Boxes.Box

  def get_boxes(), do: Box.get_boxes()

  def get_box(id), do: Box.get_boxes() |> Enum.at(id)

  def get_boxes_for_study_session(study_session) when is_integer(study_session) do
    Box.get_boxes()
    |> Enum.filter(fn box ->
      study_session in box.review_in_session
    end)
  end

  def get_retired_box_id() do
    Box.get_boxes() |> Enum.reverse() |> hd() |> Map.get(:box_id)
  end
end
