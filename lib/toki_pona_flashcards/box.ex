defmodule TokiPonaFlashcards.Box do
  alias TokiPonaFlashcards.Boxes.Box

  def get_boxes_for_study_session(study_session) when is_integer(study_session) do
    Box.get_boxes()
    |> Enum.filter(fn box ->
      study_session in box.review_in_session
    end)
  end
end
