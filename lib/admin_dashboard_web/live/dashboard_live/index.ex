defmodule AdminDashboardWeb.DashboardLive.Index do
  use Phoenix.LiveView
  alias AdminDashboard.Users
  alias AdminDashboard.SentEmails
  require Logger

  @impl true
  def mount(_params, _session, socket) do
    Logger.info("MOUNTING #{__MODULE__}.")
    socket =
      socket
      |> assign(:sort_by, "inserted_at")
      |> assign(:sort_order, "desc")
      |> assign(:user_scope, "")
      |> assign(:search_text, "")

    {:ok, socket}
  end

  @impl true
  def render(assigns), do: AdminDashboardWeb.DashboardView.render("index.html", assigns)

  @impl true
  def handle_params(%{"sort_by" => sort_by, "sort_order" => sort_order}, _url, socket) do
    socket =
      socket
      |> assign(:available_users, Users.get_users())
      |> assign(:sort_by, sort_by)
      |> assign(:sort_order, sort_order)
      |> assign_sent_emails()

    {:noreply, socket}
  end

  @impl true
  def handle_params(_params, _url, socket) do
    socket =
      socket
      |> assign(:available_users, Users.get_users())
      |> assign_sent_emails()

    {:noreply, socket}
  end

  @impl true
  def handle_event("filter", %{"filter" => %{"user_id" => user_id}}, socket) do
    socket =
      socket
      |> assign(:user_scope, user_id)
      |> assign_sent_emails()

    {:noreply, socket}
  end

  @impl true
  def handle_event("search", %{"search" => %{"text" => search_text}}, socket) do
    socket =
      socket
      |> assign(:search_text, search_text)
      |> assign_sent_emails()

    {:noreply, socket}
  end

  defp assign_sent_emails(socket) do
    %{user_scope: user_scope, search_text: search_text, sort_by: sort_by, sort_order: sort_order} = socket.assigns
    assign(socket, :sent_emails, SentEmails.get_sent_emails(user_scope, search_text, sort_by, sort_order))
  end
end
