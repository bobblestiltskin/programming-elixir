defmodule Stack.Server do
  use GenServer

  def init(list) do
    {:ok, list}
  end

  def handle_call(:pop, _from, list) do
    {:reply, hd(list), tl(list)}
  end
end
