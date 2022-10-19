defmodule AdminDashboard.SentEmails.SentEmail do
  use Ecto.Schema
  import Ecto.Changeset

  schema "sent_emails" do
    field :to,      :string
    field :subject, :string
    field :body,    :string

    belongs_to :user, AdminDashboard.Users.User

    timestamps()
  end

  def changeset(email, params \\ %{}) do
    email
    |> cast(params, [:user_id, :to, :subject, :body])
    |> validate_required([:user_id, :to, :subject, :body])
    |> assoc_constraint(:user)
  end

  def seed_changeset(email, params \\ %{}) do
    email
    |> changeset(params)
    |> cast(params, [:inserted_at])
    |> validate_required([:inserted_at])
  end
end
