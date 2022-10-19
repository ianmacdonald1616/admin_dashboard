defmodule AdminDashboardWeb.DashboardLive.NewUser do
  use Phoenix.LiveComponent
  alias AdminDashboardWeb.Router.Helpers, as: Routes
  alias AdminDashboard.Users.User
  alias AdminDashboard.Users
  require Logger

  def render(assigns), do: AdminDashboardWeb.DashboardView.render("new_user.html", assigns)

  def mount(socket) do
    {:ok, socket}
  end

  def update(assigns, socket) do
    socket =
      socket
      |> assign(assigns)
      |> assign(:changeset, Users.change_new_user(%User{}))

    {:ok, socket}
  end

  def handle_event("validate-user", %{"user" => user_params}, socket) do
    changeset =
      %User{}
      |> Users.change_new_user(user_params)
      |> Map.put(:action, :insert)
      |> IO.inspect()

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("create-user", %{"user" => user_params}, socket) do
    case Users.create_user(user_params) do
      {:ok, _user} ->
        Logger.info("#{__MODULE__} - Succesfully created user.")
        {:noreply, push_patch(socket, to: socket.assigns.return_to)}

      {:error, changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end
end
