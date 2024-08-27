defmodule TokiPonaFlashcards.Boxes.Box do
  @enforce_keys [:name, :review_in]
  defstruct [:name, :review_in]

  def get_boxes() do
    [
      %__MODULE__{name: "Always Review", review_in: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]},
      %__MODULE__{name: "Only Session 1", review_in: [0, 2, 5, 9]},
      %__MODULE__{name: "Only Session 2", review_in: [1, 3, 6, 0]},
      %__MODULE__{name: "Only Session 2", review_in: [2, 4, 7, 1]},
      %__MODULE__{name: "Only Session 2", review_in: [3, 5, 8, 2]},
      %__MODULE__{name: "Only Session 2", review_in: [4, 6, 9, 3]},
      %__MODULE__{name: "Only Session 2", review_in: [5, 7, 0, 4]},
      %__MODULE__{name: "Only Session 2", review_in: [6, 8, 1, 5]},
      %__MODULE__{name: "Only Session 2", review_in: [7, 9, 2, 6]},
      %__MODULE__{name: "Only Session 2", review_in: [8, 0, 3, 7]},
      %__MODULE__{name: "Only Session 2", review_in: [9, 1, 4, 8]},
      %__MODULE__{name: "Retired", review_in: []}
    ]
  end
end
