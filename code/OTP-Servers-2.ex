defmodule Stack.Server do
  use GenServer

  def init(list) do
    {:ok, list}
  end

  def handle_call(:pop, _from, list) do
    {:reply, hd(list), tl(list)}
  end

  def handle_cast({:push, value}, list) do
    {:noreply, [value] ++ list}
  end
end
