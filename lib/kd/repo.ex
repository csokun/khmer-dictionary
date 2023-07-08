defmodule Kd.Repo do
  use Ecto.Repo,
    otp_app: :kd,
    adapter: Ecto.Adapters.SQLite3
end
