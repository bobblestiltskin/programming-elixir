defmodule MaxList do
  def get([]), do: 0
  def get(list), do: get(list, 0)
  def get([], max), do: max
  def get([head|tail], maxv), do: get(tail, max(head, maxv))
end
