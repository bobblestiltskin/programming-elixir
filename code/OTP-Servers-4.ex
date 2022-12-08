defmodule Stack.Server do
  use GenServer

  #####
  # External API
  def start_link(list) do
    GenServer.start_link(__MODULE__, list, name: __MODULE__)
  end

  def pop do
    GenServer.call(__MODULE__, :pop)
  end

  def push(value) do
    GenServer.cast(__MODULE__, {:push, value})
  end

  #####
  # GenServer implementation

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
