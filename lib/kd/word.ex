defmodule Kd.Word do
  use Ecto.Schema

  schema "words" do
    field :level, :integer
    field :ref, :integer
    field :main, :string
    field :subscript, :string
    field :subword, :string
    field :poly, :string
    field :pronunciation, :string
    field :part_of_speech, :string
    field :definition, :string
  end
end
