defmodule :"Elixir.Kd.Repo.Migrations.Add dict table" do
  use Ecto.Migration

  def change do
    create table(:words) do
      add :level, :integer, default: 1
      add :main, :string, size: 60
      add :subscript, :string, size: 60
      add :subword, :string, size: 60
      add :definition, :string
      add :example, :string
      add :pronunciation, :string
      add :part_of_speech, :string
      add :note, :string
    end
  end
end
