defmodule StatusServer do
  use GenServer

  def start_link(url, interval) do
    GenServer.start_link(__MODULE__, [url, interval])
  end

  def init(args) do
    # Give default value of 200.
    state = 200
    interval = args[:interval]
    url = args[:url]
    IO.inspect(args[:id])

    # This will send message to self on the interval. handle_info handles it.
    :timer.send_interval(interval, url)
    {:ok, state}
  end

  def handle_info(url, state) do
    # Fooling around with accessing values in a stuct. Good times.
    # response = HTTPoison.head(url, [], [follow_redirect: true, max_redirect: 1])
    # var = Keyword.get(response, :headers)
    # IO.inspect(elem(response,1))
    # var = elem(response, 1)
    # IO.inspect(elem(response, 1).status_code)
    # Keyword.get(var.headers, :status)
    case HTTPoison.head(url) do
      {:ok, %HTTPoison.Response{status_code: 200}} ->
        IO.inspect(200)
        new_state = 200
      {:ok, %HTTPoison.Response{status_code: 404}} ->
        IO.puts "Not found :("
        new_state = 404
      {:error, %HTTPoison.Error{reason: reason}} ->
        IO.inspect reason
        new_state = -1
    end
    # new_state = state
    {:noreply, new_state}
  end
end
