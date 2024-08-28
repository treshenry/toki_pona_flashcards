defmodule TokiPonaFlashcards.Boxes.Box do
  @enforce_keys [:box_id, :review_in_session]
  defstruct [:box_id, :review_in_session]

  def get_boxes() do
    [
      %__MODULE__{box_id: 0, review_in_session: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]},
      %__MODULE__{box_id: 1, review_in_session: [0, 2, 5, 9]},
      %__MODULE__{box_id: 2, review_in_session: [1, 3, 6, 0]},
      %__MODULE__{box_id: 3, review_in_session: [2, 4, 7, 1]},
      %__MODULE__{box_id: 4, review_in_session: [3, 5, 8, 2]},
      %__MODULE__{box_id: 5, review_in_session: [4, 6, 9, 3]},
      %__MODULE__{box_id: 6, review_in_session: [5, 7, 0, 4]},
      %__MODULE__{box_id: 7, review_in_session: [6, 8, 1, 5]},
      %__MODULE__{box_id: 8, review_in_session: [7, 9, 2, 6]},
      %__MODULE__{box_id: 9, review_in_session: [8, 0, 3, 7]},
      %__MODULE__{box_id: 10, review_in_session: [9, 1, 4, 8]},
      %__MODULE__{box_id: 11, review_in_session: []}
    ]
  end
end
