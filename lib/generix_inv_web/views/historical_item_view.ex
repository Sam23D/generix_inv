defmodule GenerixInvWeb.HistoricalItemView do
  use GenerixInvWeb, :view
  alias GenerixInvWeb.HistoricalItemView

  def render("index.json", %{historical_items: historical_items}) do
    %{data: render_many(historical_items, HistoricalItemView, "historical_item.json")}
  end

  def render("show.json", %{historical_item: historical_item}) do
    %{data: render_one(historical_item, HistoricalItemView, "historical_item.json")}
  end

  def render("historical_item.json", %{historical_item: historical_item}) do
    %{id: historical_item.id,
      previous: historical_item.previous,
      after: historical_item.after,
      quantity: historical_item.quantity}
  end
end
