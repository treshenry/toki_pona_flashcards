defmodule TokiPonaFlashcards.Repo.Migrations.CreateCards do
  use Ecto.Migration

  def change do
    create table(:cards) do
      add :user_id, references(:users, on_delete: :delete_all), null: false
      add :front, :string
      add :back, :string
      add :front_sitelen, :boolean, default: false, null: false
      add :back_sitelen, :boolean, default: false, null: false

      timestamps(type: :utc_datetime)
    end
  end
end
