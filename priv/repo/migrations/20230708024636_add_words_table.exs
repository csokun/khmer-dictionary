defmodule :"Elixir.Kd.Repo.Migrations.Add dict table" do
  use Ecto.Migration

  def change do
    create table(:words) do
      add :level, :integer
      add :ref, :integer
      add :main, :string
      add :subscript, :string
      add :subword, :string
      add :source, :string
      add :poly, :string
      add :definition, :string
      add :pronunciation, :string
      add :part_of_speech, :string
    end
  end
end
