defmodule Kd.Word do
  use Ecto.Schema

  @primary_key {:id, :id, autogenerate: true, source: :rowid}
  schema "words" do
    field :main, :string
    field :subscript, :string
    field :subword, :string
    field :pronunciation, :string
    field :part_of_speech, :string
    field :definition, :string
    field :example, :string

    field :rank, :float, virtual: true
  end
end
