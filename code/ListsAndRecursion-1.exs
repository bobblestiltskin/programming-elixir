defmodule MyList do
  def mapsum(list, fun) do
    list
    |> maplist(fun)
    |> sumlist()
  end

  def maplist([], _fun), do: []
  def maplist([head | tail], fun), do: [ fun.(head) | maplist(tail, fun) ]

  def sumlist([]), do: 0
  def sumlist([head | tail]), do: head + sumlist(tail)
end
