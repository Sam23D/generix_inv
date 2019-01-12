defmodule GenerixInv.InventoryTest do
  use GenerixInv.DataCase

  alias GenerixInv.Inventory

  describe "items" do
    alias GenerixInv.Inventory.Item

    @valid_attrs %{code: "some code", description: "some description", inventory: 42}
    @update_attrs %{code: "some updated code", description: "some updated description", inventory: 43}
    @invalid_attrs %{code: nil, description: nil, inventory: nil}

    def item_fixture(attrs \\ %{}) do
      {:ok, item} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Inventory.create_item()

      item
    end

    test "list_items/0 returns all items" do
      item = item_fixture()
      assert Inventory.list_items() == [item]
    end

    test "get_item!/1 returns the item with given id" do
      item = item_fixture()
      assert Inventory.get_item!(item.id) == item
    end

    test "create_item/1 with valid data creates a item" do
      assert {:ok, %Item{} = item} = Inventory.create_item(@valid_attrs)
      assert item.code == "some code"
      assert item.description == "some description"
      assert item.inventory == 42
    end

    test "create_item/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Inventory.create_item(@invalid_attrs)
    end

    test "update_item/2 with valid data updates the item" do
      item = item_fixture()
      assert {:ok, item} = Inventory.update_item(item, @update_attrs)
      assert %Item{} = item
      assert item.code == "some updated code"
      assert item.description == "some updated description"
      assert item.inventory == 43
    end

    test "update_item/2 with invalid data returns error changeset" do
      item = item_fixture()
      assert {:error, %Ecto.Changeset{}} = Inventory.update_item(item, @invalid_attrs)
      assert item == Inventory.get_item!(item.id)
    end

    test "delete_item/1 deletes the item" do
      item = item_fixture()
      assert {:ok, %Item{}} = Inventory.delete_item(item)
      assert_raise Ecto.NoResultsError, fn -> Inventory.get_item!(item.id) end
    end

    test "change_item/1 returns a item changeset" do
      item = item_fixture()
      assert %Ecto.Changeset{} = Inventory.change_item(item)
    end
  end

  describe "historical_items" do
    alias GenerixInv.Inventory.HistoricalItem

    @valid_attrs %{after: 42, previous: 42, quantity: 42}
    @update_attrs %{after: 43, previous: 43, quantity: 43}
    @invalid_attrs %{after: nil, previous: nil, quantity: nil}

    def historical_item_fixture(attrs \\ %{}) do
      {:ok, historical_item} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Inventory.create_historical_item()

      historical_item
    end

    test "list_historical_items/0 returns all historical_items" do
      historical_item = historical_item_fixture()
      assert Inventory.list_historical_items() == [historical_item]
    end

    test "get_historical_item!/1 returns the historical_item with given id" do
      historical_item = historical_item_fixture()
      assert Inventory.get_historical_item!(historical_item.id) == historical_item
    end

    test "create_historical_item/1 with valid data creates a historical_item" do
      assert {:ok, %HistoricalItem{} = historical_item} = Inventory.create_historical_item(@valid_attrs)
      assert historical_item.after == 42
      assert historical_item.previous == 42
      assert historical_item.quantity == 42
    end

    test "create_historical_item/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Inventory.create_historical_item(@invalid_attrs)
    end

    test "update_historical_item/2 with valid data updates the historical_item" do
      historical_item = historical_item_fixture()
      assert {:ok, historical_item} = Inventory.update_historical_item(historical_item, @update_attrs)
      assert %HistoricalItem{} = historical_item
      assert historical_item.after == 43
      assert historical_item.previous == 43
      assert historical_item.quantity == 43
    end

    test "update_historical_item/2 with invalid data returns error changeset" do
      historical_item = historical_item_fixture()
      assert {:error, %Ecto.Changeset{}} = Inventory.update_historical_item(historical_item, @invalid_attrs)
      assert historical_item == Inventory.get_historical_item!(historical_item.id)
    end

    test "delete_historical_item/1 deletes the historical_item" do
      historical_item = historical_item_fixture()
      assert {:ok, %HistoricalItem{}} = Inventory.delete_historical_item(historical_item)
      assert_raise Ecto.NoResultsError, fn -> Inventory.get_historical_item!(historical_item.id) end
    end

    test "change_historical_item/1 returns a historical_item changeset" do
      historical_item = historical_item_fixture()
      assert %Ecto.Changeset{} = Inventory.change_historical_item(historical_item)
    end
  end
end
