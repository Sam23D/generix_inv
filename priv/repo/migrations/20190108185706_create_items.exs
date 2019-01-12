defmodule GenerixInv.Repo.Migrations.CreateItems do
  use Ecto.Migration

  def change do
    create table(:items) do
      add :description, :string
      add :inventory, :decimal
      add :code, :string

      timestamps()
    end

  end
end
