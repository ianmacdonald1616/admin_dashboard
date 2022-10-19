defmodule AdminDashboard.Repo do
  use Ecto.Repo,
    otp_app: :admin_dashboard,
    adapter: Ecto.Adapters.Postgres
end
