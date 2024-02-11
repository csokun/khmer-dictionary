defmodule KdWeb.HomeLive do
  use KdWeb, :live_view
  alias Phoenix.LiveView.AsyncResult

  require Logger

  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:query, "")
     |> assign(:entries, AsyncResult.loading())}
  end

  def handle_event("search", %{"q" => q}, socket) do
    {:noreply,
     socket
     |> assign_async(:entries, fn ->
       {:ok, %{entries: Kd.Dictionary.lookup("#{q}%")}}
     end)}
  end
end
