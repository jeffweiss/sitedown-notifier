defmodule StatusApp do
  use Application
  def start(_type, _args) do
    IO.puts("Starting the app...") # show that app is really starting.
    StatusSup.start_link()
  end
end
