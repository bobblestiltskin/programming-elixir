defmodule Stack.Server do
  use GenServer

  def start_link(list) do
    GenServer.start_link(__MODULE__, list, name: __MODULE__)
  end

  def pop do
    GenServer.call(__MODULE__, :pop)
  end

  def push(value) do
    GenServer.cast(__MODULE__, {:push, value})
  end

  def init(list) do
    {:ok, list}
  end

  def handle_call(:pop, _from, list) do
    {:reply, hd(list), tl(list)}
  end

  def handle_cast({:push, value}, list) do
    if is_number(value) and value < 10 do
      System.halt(value)
    else
      {:noreply, [value] ++ list}
    end
  end

  def terminate(reason, state) do
    IO.puts("Terminate reason is #{reason}")
    IO.puts("Terminate state is #{inspect(state)}")
  end
end
