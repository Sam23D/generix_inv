defmodule GenerixInv.Inventory.Item do
  use Ecto.Schema
  import Ecto.Changeset


  schema "items" do
    field :code, :string
    field :description, :string
    field :inventory, :decimal

    timestamps()
  end

  def lower_case_code(changeset)do
    changeset
    |> put_change( :code, String.downcase( get_change(changeset, :code, "")))
  end

  @doc false
  def changeset(item, attrs) do
    item
    |> cast(attrs, [:description, :inventory, :code])
    |> lower_case_code
    |> validate_required([ :inventory, :code])
    |> unique_constraint(:code)
  end

  def update_inventory(item, attrs)do
    item
    |> cast(attrs, [:inventory])
    |> validate_required([ :inventory])
  end
end
