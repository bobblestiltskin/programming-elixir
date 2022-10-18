iex(9)> Enum.map [1,2,3,4], &(&1 +2)
iex(10)> Enum.each [1,2,3,4], &(IO.inspect(&1))
