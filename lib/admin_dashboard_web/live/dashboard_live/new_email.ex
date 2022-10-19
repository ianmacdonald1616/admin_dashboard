defmodule AdminDashboardWeb.DashboardLive.NewEmail do
  use Phoenix.LiveComponent

  alias AdminDashboardWeb.Router.Helpers, as: Routes
  alias AdminDashboard.Users
  alias AdminDashboard.SentEmails
  alias AdminDashboard.SentEmails.SentEmail

  require Logger

  def render(assigns), do: AdminDashboardWeb.DashboardView.render("new_email.html", assigns)

  def mount(socket) do
    {:ok, socket}
  end

  def update(assigns, socket) do
    socket =
      socket
      |> assign(assigns)
      |> assign(:changeset, SentEmails.change_new_sent_email(%SentEmail{}))

    {:ok, socket}
  end

  def handle_event("validate-email", %{"sent_email" => email_params}, socket) do
    changeset =
      %SentEmail{}
      |> SentEmails.change_new_sent_email(email_params)
      |> Map.put(:action, :insert)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("create-email", %{"sent_email" => email_params}, socket) do
    case SentEmails.create_sent_email(email_params) do
      {:ok, _email} ->
        Logger.info("#{__MODULE__} - Succesfully created email.")
        {:noreply, push_patch(socket, to: socket.assigns.return_to)}

      {:error, changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end
end
