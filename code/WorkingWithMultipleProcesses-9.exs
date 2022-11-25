defmodule Cat do
  def count(scheduler) do
    send(scheduler, {:ready, self()})

    receive do
      {:count, filename, client} ->
#        IO.inspect(filename, label: "filename")
        send(client, {:answer, filename, count_cats(filename), self()})
        count(scheduler)

      {:shutdown} ->
        exit(:normal)
    end
  end

  def count_cats(file) do
#    contents = File.read!(file)
#    IO.inspect(contents, label: "contents")
#    contents |> String.split("cat") |> Enum.drop(1) |> length()
    File.read!(file)
    |> String.split("cat")
    |> Enum.drop(1)
    |> length()
  end
end

defmodule Scheduler do
  def run(num_processes, module, func, to_calculate) do
    1..num_processes
    |> Enum.map(fn _ -> spawn(module, func, [self()]) end)
    |> schedule_processes(to_calculate, [])
  end

  defp schedule_processes(processes, queue, results) do
    receive do
      {:ready, pid} when queue != [] ->
        [next | tail] = queue
#        IO.inspect(next, label: "next")
        send(pid, {:count, next, self()})
        schedule_processes(processes, tail, results)

      {:ready, pid} ->
        send(pid, {:shutdown})

        if length(processes) > 1 do
          schedule_processes(List.delete(processes, pid), queue, results)
        else
          Enum.sort(results, fn {n1, _}, {n2, _} -> n1 <= n2 end)
        end

      {:answer, number, result, _pid} ->
        schedule_processes(processes, queue, [{number, result} | results])
    end
  end
end

defmodule Controller do
  def run(directory) do
    to_process = File.ls!(directory)
    to_process = Enum.map(to_process, fn x -> directory <> "/" <> x end)
#    IO.inspect(to_process, label: "to_process")
    num_files = length(to_process)
    Scheduler.run(num_files, Cat, :count, to_process)
  end
end
