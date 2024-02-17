defmodule KdWeb.HomeLive do
  use KdWeb, :live_view
  alias Phoenix.LiveView.AsyncResult

  require Logger

  embed_templates "home_live/*"

  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:query, "")
     |> assign(:entries, AsyncResult.loading()), temporary_assigns: [entries: []]}
  end

  def handle_params(params, _url, socket) do
    q = Map.get(params, "q", "")

    if q == socket.assigns.query do
      {:noreply, socket}
    else
      {:noreply,
       socket
       |> assign(:query, q)
       |> search(q)}
    end
  end

  def handle_event("speak", %{"text" => text}, socket) do
    tts_base_url = System.get_env("TTS_BASE_URL", "http://localhost:3000")

    {:noreply,
     socket
     |> push_event("play", %{url: "#{tts_base_url}/#{text}"})}
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

  def toggle_subword(js \\ %JS{}, id) do
    btn_class = "bg-sky-500 text-white"

    js
    |> JS.remove_class(btn_class, to: ".subword-btn")
    |> JS.add_class(btn_class, to: "#subword-#{id}-btn")
    |> JS.hide(to: ".subword")
    |> JS.show(to: "#subword-#{id}")
  end
end
