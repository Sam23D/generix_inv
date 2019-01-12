defmodule GenerixInv.Repo.Migrations.CreateUniqueItemCode do
  use Ecto.Migration

  def change do
    create unique_index(:items, [:code])
  end
end
