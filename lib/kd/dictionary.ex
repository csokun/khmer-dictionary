defmodule Kd.Dictionary do
  import Ecto.Query, only: [from: 2]
  alias Kd.Word

  def lookup(word) do
    from(d in Word,
      select: [:main, :subword, :pronunciation, :part_of_speech, :definition, :example, :rank, :id],
      where: fragment("words MATCH ?", ^word),
      order_by: [asc: :rank])
    |> Kd.Repo.all()
  end
end
