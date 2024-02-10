defmodule Kd.Word do
  use Ecto.Schema

  @primary_key {:id, :id, autogenerate: true, source: :rowid}
  schema "words" do
    field :level, :integer
    field :main, :string
    field :subscript, :string
    field :subword, :string
    field :pronunciation, :string
    field :part_of_speech, :string
    field :definition, :string
    field :note, :string
    field :example, :string
  end
end
