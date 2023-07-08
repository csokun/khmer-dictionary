defmodule Kd.Dictionary do
  import Ecto.Query, only: [from: 2]
  alias Kd.Word

  def lookup(word) do
    query =
      from w in Word,
        where: w.main == ^word,
        select: w.definition

    Kd.Repo.all(query)
  end
end
