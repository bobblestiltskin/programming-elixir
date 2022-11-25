defmodule MyLink do
  import :timer, only: [sleep: 1]

  def my_function(ppid) do
    send ppid, "HELLO FROM MY_FUNCTION"
#    exit(:out_of_here)
  end

  def read do
    receive do
      msg ->
        IO.puts("MESSAGE RECEIVED: #{inspect(msg)}")
#    after
#      1000 ->
#        IO.puts("Nothing happened as far as I am concerned")
    end

    read()
  end

  def run do
    spawn_link(MyLink, :my_function, [self()])
    sleep(500)
    read()
  end
end
