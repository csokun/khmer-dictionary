defmodule KdWeb.HomeLive do
  use KdWeb, :live_view

  require Logger

  def mount(_params, _session, socket) do
    socket = socket |> assign(query: "", entries: [])
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <div class="relative flex-1">
      <form phx-submit="search">
        <button class="absolute top-2 right-2" type="submit">
          <svg
            xmlns="http://www.w3.org/2000/svg"
            class="w-6 h-6 opacity-60"
            fill="none"
            viewBox="0 0 24 24"
            stroke="currentColor"
          >
            <path
              stroke-linecap="round"
              stroke-linejoin="round"
              stroke-width="2"
              d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"
            />
          </svg>
        </button>
        <input
          class="w-full px-2 py-2 text-sm border border-gray-300 rounded-lg shadow-sm focus:outline-none focus:border-indigo-500 focus:ring-1"
          phx-debounce="300"
          placeholder="Search"
          name="q"
          id="q"
          value={@query}
        />
      </form>

      <div :for={entry <- @entries} class="flex flex-col p-4 space-y-2">
        <div>
          <span :if={entry.subword != ""}>
            <%= entry.subword %>
          </span>
          <span :if={entry.subword == ""}>
            <%= entry.main %>
          </span>
          <span :if={entry.part_of_speech != ""}>[ <%= entry.part_of_speech %> ]</span>
        </div>
        <p><%= entry.definition %></p>
        <div :if={entry.example != ""}>
          <span>ឧទាហរណ៍៖</span>
          <%= entry.example %>
        </div>
        <div :if={entry.pronunciation != ""}>
          <span>អានថា៖</span>
          <%= entry.pronunciation %>
        </div>
      </div>
    </div>
    """
  end

  def handle_event("search", %{"q" => q}, socket) do
    Logger.info("Searching for #{q}")
    results = Kd.Dictionary.lookup(q)
    Logger.info("Found #{length(results)} results")
    {:noreply, assign(socket, :entries, results)}
  end
end
