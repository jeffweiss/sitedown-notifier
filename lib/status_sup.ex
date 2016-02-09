defmodule StatusSup do
  use Supervisor
  # convenience method for startup
  def start_link do
    Supervisor.start_link(__MODULE__, [], [{:name, __MODULE__}])
  end
  # supervisor callback
  def init([]) do
    interval = Application.get_env(StatusApp, :interval, 30000)

    child_site_workers =
      for site <- Application.get_env(StatusApp, :sites) do
        worker(StatusServer, [url: site, interval: interval], [id: site])
      end
    children = [worker(ConCache, [[], [name: :url_cache]])|child_site_workers]

    supervise(children, [{:strategy, :one_for_one}, {:max_restarts, 5},
    {:max_seconds, 30}])
  end
  # Internal functions (none here)
end
