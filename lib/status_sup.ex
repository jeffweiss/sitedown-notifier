defmodule StatusSup do
  use Supervisor
  # convenience method for startup
  def start_link do
    Supervisor.start_link(__MODULE__, [], [{:name, __MODULE__}])
  end
  # supervisor callback
  def init([]) do
    child = [
      worker(StatusServer, [url: "sheldonkreger.com", interval: 1000], [id: "sheldonkreger.com"]),
      worker(StatusServer, [url: "prodrumblog.com", interval: 1000], [id: "prodrumblog.com"]),
      worker(ConCache, [[], [name: :url_cache]])
    ]
    supervise(child, [{:strategy, :one_for_one}, {:max_restarts, 5},
    {:max_seconds, 30}])
  end
  # Internal functions (none here)
end
