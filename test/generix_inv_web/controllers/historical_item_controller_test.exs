defmodule GenerixInvWeb.HistoricalItemControllerTest do
  use GenerixInvWeb.ConnCase

  alias GenerixInv.Inventory
  alias GenerixInv.Inventory.HistoricalItem

  @create_attrs %{after: 42, previous: 42, quantity: 42}
  @update_attrs %{after: 43, previous: 43, quantity: 43}
  @invalid_attrs %{after: nil, previous: nil, quantity: nil}

  def fixture(:historical_item) do
    {:ok, historical_item} = Inventory.create_historical_item(@create_attrs)
    historical_item
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all historical_items", %{conn: conn} do
      conn = get conn, historical_item_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create historical_item" do
    test "renders historical_item when data is valid", %{conn: conn} do
      conn = post conn, historical_item_path(conn, :create), historical_item: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, historical_item_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "after" => 42,
        "previous" => 42,
        "quantity" => 42}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, historical_item_path(conn, :create), historical_item: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update historical_item" do
    setup [:create_historical_item]

    test "renders historical_item when data is valid", %{conn: conn, historical_item: %HistoricalItem{id: id} = historical_item} do
      conn = put conn, historical_item_path(conn, :update, historical_item), historical_item: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, historical_item_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "after" => 43,
        "previous" => 43,
        "quantity" => 43}
    end

    test "renders errors when data is invalid", %{conn: conn, historical_item: historical_item} do
      conn = put conn, historical_item_path(conn, :update, historical_item), historical_item: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete historical_item" do
    setup [:create_historical_item]

    test "deletes chosen historical_item", %{conn: conn, historical_item: historical_item} do
      conn = delete conn, historical_item_path(conn, :delete, historical_item)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, historical_item_path(conn, :show, historical_item)
      end
    end
  end

  defp create_historical_item(_) do
    historical_item = fixture(:historical_item)
    {:ok, historical_item: historical_item}
  end
end
