defmodule TokiPonaFlashcards.Repo do
  use Ecto.Repo,
    otp_app: :toki_pona_flashcards,
    adapter: Ecto.Adapters.SQLite3
end
