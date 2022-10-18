defmodule Chop do
  def guess(find, range) do
    first..last = range
    half = first + div(last - first, 2)
    IO.puts("Is it #{half}")
    cond do
      find == half ->
        IO.puts("#{find}")
      find < half ->
        guess(find, first..half)
      find > half ->
        guess(find, half+1..last)
    end
  end
end
