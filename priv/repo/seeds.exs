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
defmodule SeedHelper do
  def import do
    case read_json_from_zip("priv/db.zip", "db.json") do
      {:ok, json} ->
        import_entries(json)

      {:error, reason} ->
        IO.puts("error #{reason}")
    end
  end

  defp read_json_from_zip(zip_file, json_filename) do
    with {:ok, file} = File.read(zip_file),
         {:ok, zip_ref} = :zip.zip_open(file, [:memory]),
         {:ok, {_, content}} = :zip.zip_get(json_filename, zip_ref),
         :zip.zip_close(zip_ref) do
      result =
        case Jason.decode(content) do
          {:ok, parsed_json} ->
            {:ok, parsed_json}

          {:error, reason} ->
            {:error, "Failed to parse JSON: #{reason}"}
        end

      result
    end
  end

  defp import_entries(entries) do
    entries
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
end

SeedHelper.import()
