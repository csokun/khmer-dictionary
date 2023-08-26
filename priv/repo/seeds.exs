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
                    "main" => main,
                    "subscript" => subscript,
                    "subword" => subword,
                    "pronunciation" => pronunciation,
                    "part_of_speech" => part_of_speech,
                    "example" => example,
                    "definition" => definition
                  } ->
    Kd.Repo.insert!(%Kd.Word{
      main: main,
      subscript: subscript,
      subword: subword,
      pronunciation: pronunciation,
      part_of_speech: part_of_speech,
      example: example,
      definition: definition
    })
  end)
end
