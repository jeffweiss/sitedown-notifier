defmodule StatusServer do
  use GenServer

  def start_link(url, interval) do
    GenServer.start_link(__MODULE__, [url, interval], [{:name, __MODULE__}])
  end

  def init(args) do
    # Give default value of 200.
    state = 200
    interval = args[:interval]
    url = args[:url]

    # This will send message to self on the interval. handle_info handles it.
    :timer.send_interval(interval, url)
    {:ok, state}
  end

  def handle_info(url, state) do
    out = HTTPoison.head(url, [], [follow_redirect: true, max_redirect: 1])
    IO.inspect(out)
    {:noreply, state}
  end
end
