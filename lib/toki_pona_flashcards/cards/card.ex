defmodule TokiPonaFlashcards.Cards.Card do
  use Ecto.Schema
  import Ecto.Changeset

  schema "cards" do
    field :front, :string
    field :back, :string
    field :front_sitelen, :boolean, default: false
    field :back_sitelen, :boolean, default: false

    belongs_to :user, TokiPonaFlashcards.Accounts.User

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(card, attrs) do
    card
    |> cast(attrs, [:user_id, :front, :back, :front_sitelen, :back_sitelen])
    |> validate_required([:user_id, :front, :back, :front_sitelen, :back_sitelen])
  end
end
