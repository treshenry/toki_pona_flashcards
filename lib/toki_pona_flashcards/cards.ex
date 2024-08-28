defmodule TokiPonaFlashcards.Cards do
  @moduledoc """
  The Cards context.
  """

  import Ecto.Query, warn: false

  alias TokiPonaFlashcards.Repo
  alias TokiPonaFlashcards.Cards.Card
  alias TokiPonaFlashcards.Accounts.User
  alias TokiPonaFlashcards.Boxes

  @doc """
  Returns the list of cards.

  ## Examples

      iex> list_cards()
      [%Card{}, ...]

  """
  def list_cards do
    Repo.all(Card)
  end

  @doc """
  Gets a single card.

  Raises `Ecto.NoResultsError` if the Card does not exist.

  ## Examples

      iex> get_card!(123)
      %Card{}

      iex> get_card!(456)
      ** (Ecto.NoResultsError)

  """
  def get_card!(id), do: Repo.get!(Card, id)

  def get_cards_for_session(%User{} = user, study_session) when is_integer(study_session) do
    Boxes.get_boxes_for_study_session(study_session)
    |> Enum.map(fn box ->
      Card.get_cards_in_box_query(user, box.box_id) |> Repo.all()
    end)
    |> List.flatten()
    |> Enum.shuffle()
  end

  def get_review_sessions_label(%Card{} = card) do
    sessions_list = Boxes.get_boxes() |> Enum.at(card.box) |> Map.get(:review_in_session)

    case sessions_list do
      sl when length(sl) > 4 -> "All sessions"
      sl -> Enum.join(sl, ", ")
    end
  end

  @doc """
  Creates a card.

  ## Examples

      iex> create_card(%{field: value})
      {:ok, %Card{}}

      iex> create_card(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_card(attrs \\ %{}) do
    %Card{}
    |> Card.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a card.

  ## Examples

      iex> update_card(card, %{field: new_value})
      {:ok, %Card{}}

      iex> update_card(card, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_card(%Card{} = card, attrs) do
    card
    |> Card.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a card.

  ## Examples

      iex> delete_card(card)
      {:ok, %Card{}}

      iex> delete_card(card)
      {:error, %Ecto.Changeset{}}

  """
  def delete_card(%Card{} = card) do
    Repo.delete(card)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking card changes.

  ## Examples

      iex> change_card(card)
      %Ecto.Changeset{data: %Card{}}

  """
  def change_card(%Card{} = card, attrs \\ %{}) do
    Card.changeset(card, attrs)
  end
end
