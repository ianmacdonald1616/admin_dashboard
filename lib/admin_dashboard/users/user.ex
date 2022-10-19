defmodule AdminDashboard.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Inspect, except: [:password]}

  schema "users" do
    field :email, :string
    field :invited_at, :naive_datetime
    field :name, :string
    field :password, :string, virtual: true, redact: true
    field :hashed_password, :string, redact: true
    field :accepted_at, :naive_datetime

    has_many :emails_sent, AdminDashboard.SentEmails.SentEmail

    timestamps()
  end

  def changeset(changeset, attrs) do
    changeset
    |> email_changeset(attrs)
    |> profile_changeset(attrs)
    |> password_changeset(attrs)
  end

  def accept_invitation_changeset(user, attrs) do
    now = NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second)

    user
    |> email_changeset(attrs)
    |> profile_changeset(attrs)
    |> password_changeset(attrs)
    |> put_change(:accepted_at, now)
  end

  # Email & password validations removed for simplicity
  def email_changeset(user, attrs) do
    user
    |> cast(attrs, [:email])
    |> validate_required([:email])
    # |> validate_email()
  end

  def profile_changeset(user, attrs) do
    user
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end

  def password_changeset(user, attrs) do
    user
    |> cast(attrs, [:password])
    # |> validate_password(opts)
  end
end
