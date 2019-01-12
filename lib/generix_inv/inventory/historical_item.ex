defmodule GenerixInv.Inventory.HistoricalItem do
  use Ecto.Schema
  import Ecto.Changeset


  schema "historical_items" do
    field :after, :decimal
    field :previous, :decimal
    field :quantity, :decimal
    field :item_id, :id

    timestamps()
  end

  @doc false
  def changeset(historical_item, attrs) do
    historical_item
    |> cast(attrs, [:previous, :after, :quantity])
    |> validate_required([:quantity])
  end

  def changeset_w_item(historical_item, attrs) do
    historical_item
    |> cast(attrs, [:previous, :after, :quantity, :item_id])
    |> validate_required([:previous, :after, :quantity, :item_id])
  end

end
