defmodule TokiPonaFlashcards.Cards.Card do
  use Ecto.Schema

  import Ecto.Changeset
  import Ecto.Query

  schema "cards" do
    field :front, :string
    field :back, :string
    field :front_sitelen, :boolean, default: false
    field :back_sitelen, :boolean, default: false
    field :box, :integer, default: 0

    belongs_to :user, TokiPonaFlashcards.Accounts.User

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(card, attrs) do
    card
    |> cast(attrs, [:user_id, :front, :back, :front_sitelen, :back_sitelen, :box])
    |> validate_required([:user_id, :front, :back, :front_sitelen, :back_sitelen, :box])
  end

  def list_cards_for_user_query(user) do
    from card in __MODULE__, where: card.user_id == ^user.id, order_by: [desc: card.inserted_at]
  end

  def get_cards_in_box_query(user, box) do
    from card in __MODULE__,
      where: card.user_id == ^user.id and card.box == ^box
  end
end
