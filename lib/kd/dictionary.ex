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
        :example,
        :id
      ],
      where: fragment("(CASE WHEN subword = '' THEN main ELSE subword END) like ?", ^keyword)
    )
    |> Kd.Repo.all()
  end
end
