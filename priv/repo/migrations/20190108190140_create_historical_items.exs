defmodule GenerixInv.Repo.Migrations.CreateHistoricalItems do
  use Ecto.Migration

  def change do
    create table(:historical_items) do
      add :previous, :decimal
      add :after, :decimal
      add :quantity, :decimal
      add :item_id, references(:items, on_delete: :nothing)

      timestamps()
    end

    create index(:historical_items, [:item_id])
  end
end
