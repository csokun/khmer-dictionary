defmodule Kd.Dictionary do
  import Ecto.Query, only: [from: 2]

  def lookup(word) when is_bitstring(word) do
    query =
      from r in "words",
        left_join: c in "words",
        on: c.level == 2 and r.main == c.main and r.subscript == c.subscript,
        where: like(r.main, ^word) and r.level == 1 and r.subword == "",
        group_by: [
          r.id,
          r.main,
          r.subscript,
          r.part_of_speech,
          r.definition,
          r.note,
          r.example,
          r.pronunciation
        ],
        select: %{
          id: r.id,
          main: r.main,
          subscript: r.subscript,
          part_of_speech: r.part_of_speech,
          definition: r.definition,
          pronunciation: r.pronunciation,
          note: r.note,
          example: r.example,
          subwords:
            fragment(
              "json_group_array(
                json_object(
                  'id', ?,
                  'main', ?,
                  'definition', ?,
                  'example', ?,
                  'pronunciation', ?,
                  'part_of_speech', ?,
                  'note', ?
                )
              ) filter (where ? is not null)",
              c.id,
              c.subword,
              c.definition,
              c.example,
              c.pronunciation,
              c.part_of_speech,
              c.note,
              c.subword
            )
        }

    Kd.Repo.all(query)
    |> Enum.map(fn row ->
      row
      |> Map.put(:subwords, Jason.decode!(row.subwords))
      |> Map.put(:id, row.id)
    end)
  end
end
