defmodule GenerixInvWeb.ItemController do
  use GenerixInvWeb, :controller

  alias GenerixInv.Inventory
  alias GenerixInv.Inventory.Item

  action_fallback GenerixInvWeb.FallbackController

  def index(conn, _params) do
    items = Inventory.list_items()
    render(conn, "index.json", items: items)
  end

  def create(conn, %{"item" => item_params}) do
    with {:ok, %Item{} = item} <- Inventory.create_item(item_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", item_path(conn, :show, item))
      |> render("show.json", item: item)
    end
  end

  def show(conn, %{"id" => id}) do
    item = Inventory.get_item!(id)
    render(conn, "show.json", item: item)
  end

  def update(conn, %{"id" => id, "item" => item_params}) do
    item = Inventory.get_item!(id)

    with {:ok, %Item{} = item} <- Inventory.update_item(item, item_params) do
      render(conn, "show.json", item: item)
    end
  end

  #Updates item inventory, and creates historical_item record bases in current inventory
  def update_inventory(conn, %{"id" => id, "inventory" => inventory})do
    with  {:ok, item} <- Inventory.get_item(id),
          {:ok, historical_item} <- Inventory.create_historical_item_from_inventory_item_update(item, inventory),
          {:ok, item } <- Inventory.update_item(item, %{ "inventory" => inventory})
    do
      IO.inspect item.inventory
      send_resp(conn, :no_content, "")
    else
      {:error, :not_found} ->
        send_resp(conn, 404, "")
    end 
  end

  def delete(conn, %{"id" => id}) do
    item = Inventory.get_item!(id)
    with {:ok, %Item{}} <- Inventory.delete_item(item) do
      send_resp(conn, :no_content, "")
    end
  end
end
