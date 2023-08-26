defmodule :"Elixir.Kd.Repo.Migrations.Add dict table" do
  use Ecto.Migration

  def change do
    create table(:words) do
      add :main, :string
      add :subscript, :string
      add :subword, :string
      add :source, :string
      add :poly, :string
      add :definition, :string
      add :example, :string
      add :pronunciation, :string
      add :part_of_speech, :string
    end

    # execute("""
    #   CREATE VIRTUAL TABLE IF NOT EXISTS words USING fts5(
    #     source UNINDEXED,
    #     មីនpoly UNINDEXED,
    #     subscript UNINDEXED,
    #     part_of_speech UNINDEXED,
    #     pronunciation UNINDEXED,
    #     main,
    #     definition UNINDEXED,
    #     subword UNINDEXED,
    #     example UNINDEXED,
    #   );
    # """)
  end
end
