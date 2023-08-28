defmodule KdWeb.HomeLive do
  use KdWeb, :live_view

  require Logger

  def mount(_params, _session, socket) do
    socket = socket |> assign(query: "", entries: [])
    {:ok, socket}
  end

  def handle_event("search", %{"q" => q}, socket) do
    Logger.info("Searching for #{q}")
    results = Kd.Dictionary.lookup(q)
    Logger.info("Found #{length(results)} results")
    {:noreply, assign(socket, :entries, results)}
  end
end
