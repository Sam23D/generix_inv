defmodule GenerixInvWeb.HistoricalItemController do
  use GenerixInvWeb, :controller

  alias GenerixInv.Inventory
  alias GenerixInv.Inventory.HistoricalItem
  alias GenerixInv.Inventory.Item

  action_fallback GenerixInvWeb.FallbackController

  def index(conn, _params) do
    historical_items = Inventory.list_historical_items()
    render(conn, "index.json", historical_items: historical_items)
  end
  
  def create(conn, %{"historical_item" => historical_item_params}) do
    with {:ok, %HistoricalItem{} = historical_item} <- Inventory.create_historical_item(historical_item_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", historical_item_path(conn, :show, historical_item))
      |> render("show.json", historical_item: historical_item)
    end
  end

  def show(conn, %{"id" => id}) do
    historical_item = Inventory.get_historical_item!(id)
    render(conn, "show.json", historical_item: historical_item)
  end

  def update(conn, %{"id" => id, "historical_item" => historical_item_params}) do
    historical_item = Inventory.get_historical_item!(id)

    with {:ok, %HistoricalItem{} = historical_item} <- Inventory.update_historical_item(historical_item, historical_item_params) do
      render(conn, "show.json", historical_item: historical_item)
    end
  end

  def delete(conn, %{"id" => id}) do
    historical_item = Inventory.get_historical_item!(id)
    with {:ok, %HistoricalItem{}} <- Inventory.delete_historical_item(historical_item) do
      send_resp(conn, :no_content, "")
    end
  end
end
