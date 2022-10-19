defmodule AdminDashboardWeb.DashboardView do
  use AdminDashboardWeb, :view
  import Phoenix.Component

  def format_sender_options(users) do
    users
    |> Enum.map(&({&1.name, &1.id}))
  end

  def table_sort_link(assigns) do
    ~H"""
    <.link patch={Routes.dashboard_index_path(@socket, :index, sort_by: @link_value, sort_order: toggle_sort_order(@sort_order))}
      class="sorting-link">
      <%= sort_text(@link_text, @sort_order, @sort_by, @link_value) %>
    </.link>
    """
  end

  defp sort_text(link_name, "asc", active_sort, link) when active_sort == link do
    [
      content_tag(:span, link_name, class: "active-sort"),
      content_tag(:i, "", class: "sorting-icon fas fa-sort-up")
    ]
  end
  defp sort_text(link_name, "desc", active_sort, link) when active_sort == link do
    [
      content_tag(:span, link_name, class: "active-sort"),
      content_tag(:i, "", class: "sorting-icon fas fa-sort-down")
    ]
  end
  defp sort_text(link_name, _, _, _) do
    [
      content_tag(:span, link_name),
      content_tag(:i, "", class: "sorting-icon fas fa-sort inactive-sort")
    ]
  end

  defp toggle_sort_order("asc"), do: "desc"
  defp toggle_sort_order("desc"), do: "asc"
end
