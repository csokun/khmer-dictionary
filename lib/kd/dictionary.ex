defmodule Kd.Dictionary do
  import Ecto.Query, only: [from: 2]
  alias Kd.Word

  def lookup(word) do
    keyword = "#{word}%"

    from(d in Word,
      select: [
        :main,
        :subword,
        :pronunciation,
        :part_of_speech,
        :definition,
        :note,
        :example
      ],
      where: like(d.main, ^keyword),
      order_by: [asc: d.main, asc: d.level, asc: d.subscript]
    )
    |> Kd.Repo.all()
  end
end
