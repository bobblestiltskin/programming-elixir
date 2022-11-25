defmodule Spawner do
  def sub do
    receive do
      {sender, token} ->
        send(sender, {:ok, token})
        sub()
    end
  end
end

defmodule Runner do
  def run do
    pid1 = spawn(Spawner, :sub, [])
#    IO.inspect(pid1, label: "pid1")
    pid2 = spawn(Spawner, :sub, [])
#    IO.inspect(pid2, label: "pid2")

    send(pid1, {self(), "fred"})
    send(pid2, {self(), "betty"})

    receive do
      {:ok, message} ->
        IO.puts(message)
    end

    receive do
      {:ok, message} ->
        IO.puts(message)
    end
  end
end
