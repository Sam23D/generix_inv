defmodule GenerixInv.Inventory do
  @moduledoc """
  The Inventory context.
  """

  import Ecto.Query, warn: false
  alias GenerixInv.Repo

  alias GenerixInv.Inventory.Item
  alias Decimal, as: D

  @doc """
  Returns the list of items.

  ## Examples

      iex> list_items()
      [%Item{}, ...]

  """
  def list_items do
    Repo.all(Item)
  end

  @doc """
  Gets a single item.

  Raises `Ecto.NoResultsError` if the Item does not exist.

  ## Examples

      iex> get_item!(123)
      %Item{}

      iex> get_item!(456)
      ** (Ecto.NoResultsError)

  """
  def get_item!(id), do: Repo.get!(Item, id)

  def get_item(id) do
      case Repo.get_by( Item, id: id) do
          nil -> {:error, :not_found}
          item -> {:ok, item}
      end
  end

  @doc """
  Creates a item.

  ## Examples

      iex> create_item(%{field: value})
      {:ok, %Item{}}

      iex> create_item(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_item(attrs \\ %{}) do
    %Item{}
    |> Item.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a item.

  ## Examples

      iex> update_item(item, %{field: new_value})
      {:ok, %Item{}}

      iex> update_item(item, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_item(%Item{} = item, attrs) do
    item
    |> Item.update_inventory(attrs)
    |> Repo.update()
  end

  def update_item_inventory(%Item{} = item, new_inventory) do

  end

  @doc """
  Deletes a Item.

  ## Examples

      iex> delete_item(item)
      {:ok, %Item{}}

      iex> delete_item(item)
      {:error, %Ecto.Changeset{}}

  """
  def delete_item(%Item{} = item) do
    Repo.delete(item)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking item changes.

  ## Examples

      iex> change_item(item)
      %Ecto.Changeset{source: %Item{}}

  """
  def change_item(%Item{} = item) do
    Item.changeset(item, %{})
  end

  alias GenerixInv.Inventory.HistoricalItem

  @doc """
  Returns the list of historical_items.

  ## Examples

      iex> list_historical_items()
      [%HistoricalItem{}, ...]

  """
  def list_historical_items do
    Repo.all(HistoricalItem)
  end

  @doc """
  Gets a single historical_item.

  Raises `Ecto.NoResultsError` if the Historical item does not exist.

  ## Examples

      iex> get_historical_item!(123)
      %HistoricalItem{}

      iex> get_historical_item!(456)
      ** (Ecto.NoResultsError)

  """
  def get_historical_item!(id), do: Repo.get!(HistoricalItem, id)


  @doc """
  Creates a historical_item.

  ## Examples

      iex> create_historical_item(%{field: value})
      {:ok, %HistoricalItem{}}

      iex> create_historical_item(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_historical_item(attrs \\ %{}) do
    %HistoricalItem{}
    |> HistoricalItem.changeset(attrs)
    |> Repo.insert()
  end

  def create_historical_item_w_item_relation(attrs \\ %{}) do
    %HistoricalItem{}
    |> HistoricalItem.changeset_w_item(attrs)
    |> Repo.insert()
  end

  def create_historical_item_from_inventory_item_update(prev_item, new_qty)do
    
    diff = D.add( new_qty, D.minus( prev_item.inventory))
    with    {:ok, historical_item} <- create_historical_item_w_item_relation(%{
                                        "after" => new_qty,
                                        "previous" => prev_item.inventory,
                                        "item_id" => prev_item.id,
                                        "quantity" => diff
                                    })
    do
        {:ok, historical_item }
    end
  end

  @doc """
  Updates a historical_item.

  ## Examples

      iex> update_historical_item(historical_item, %{field: new_value})
      {:ok, %HistoricalItem{}}

      iex> update_historical_item(historical_item, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_historical_item(%HistoricalItem{} = historical_item, attrs) do
    historical_item
    |> HistoricalItem.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a HistoricalItem.

  ## Examples

      iex> delete_historical_item(historical_item)
      {:ok, %HistoricalItem{}}

      iex> delete_historical_item(historical_item)
      {:error, %Ecto.Changeset{}}

  """
  def delete_historical_item(%HistoricalItem{} = historical_item) do
    Repo.delete(historical_item)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking historical_item changes.

  ## Examples

      iex> change_historical_item(historical_item)
      %Ecto.Changeset{source: %HistoricalItem{}}

  """
  def change_historical_item(%HistoricalItem{} = historical_item) do
    HistoricalItem.changeset(historical_item, %{})
  end
end
