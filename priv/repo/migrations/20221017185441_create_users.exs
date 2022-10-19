defmodule AdminDashboard.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
   execute "CREATE EXTENSION IF NOT EXISTS citext", ""

   create table(:users) do
     add :email, :citext, null: false
     add :invited_at, :naive_datetime
     add :accepted_at, :naive_datetime
     add :name, :string
     add :hashed_password, :string
     timestamps()
   end
 end
end
