# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Kd.Repo.insert!(%Kd.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
with {:ok, body} <- File.read("priv/db.json"),
     {:ok, records} <- Jason.decode(body) do
  records
  |> Enum.each(fn %{
                    "level" => level,
                    "ref" => ref,
                    "main" => main,
                    "subscript" => subscript,
                    "subword" => subword,
                    "poly" => poly,
                    "pronunciation" => pronunciation,
                    "part_of_speech" => part_of_speech,
                    "definition" => definition
                  } ->
    Kd.Repo.insert!(%Kd.Word{
      level: level,
      ref: ref,
      main: main,
      subscript: subscript,
      subword: subword,
      poly: poly,
      pronunciation: pronunciation,
      part_of_speech: part_of_speech,
      definition: definition
    })
  end)
end
