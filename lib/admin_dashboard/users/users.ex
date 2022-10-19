defmodule AdminDashboard.Users do
  import Ecto.Query, warn: false

  alias AdminDashboard.Repo
  alias AdminDashboard.Users.User
  alias AdminDashboard.SentEmails.SentEmail

  def create_user(params) do
    %User{}
    |> User.accept_invitation_changeset(params)
    |> Repo.insert()
  end

  # Setting default password that invited users would usually create themselves.
  def change_new_user(user, params \\ %{}) do
    user
    |> User.accept_invitation_changeset(Map.merge(params, %{"password" => "very0sekrit", "password_confirmation" => "very0sekrit"}))
  end

  def get_users() do
    Repo.all(from u in User)
  end
end
