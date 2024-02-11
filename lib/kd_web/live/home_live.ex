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

  def handle_params(params, _url, socket) do
    q = Map.get(params, "q", "")

    {:noreply,
     socket
     |> assign(:query, q)
     |> search(q)}
  end

  def handle_event("search", %{"q" => q}, socket) do
    {:noreply, socket |> push_patch(to: ~p"/?q=#{q}")}
  end

  defp search(socket, "") do
    socket
    |> assign_async(:entries, fn -> {:ok, %{entries: []}} end)
  end

  defp search(socket, q) do
    socket
    |> assign_async(:entries, fn ->
      {:ok, %{entries: Kd.Dictionary.lookup("#{q}%")}}
    end)
  end
end
