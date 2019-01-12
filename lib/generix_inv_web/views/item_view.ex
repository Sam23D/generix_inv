defmodule GenerixInvWeb.ItemView do
  use GenerixInvWeb, :view
  alias GenerixInvWeb.ItemView

  def render("index.json", %{items: items}) do
    %{data: render_many(items, ItemView, "item.json")}
  end

  def render("show.json", %{item: item}) do
    %{data: render_one(item, ItemView, "item.json")}
  end

  def render("item.json", %{item: item}) do
    %{id: item.id,
      description: item.description,
      inventory: item.inventory,
      code: item.code}
  end
end
