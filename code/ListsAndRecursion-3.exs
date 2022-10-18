# ascii decimal code for z is 122
defmodule MyList do
  def caesar([], _), do: []
  def caesar([head|tail], n) do
    sum = head + n
    newsum = if sum > 122 do
      sum - 26
    else
      sum
    end
    [ newsum | caesar(tail, n) ]
  end
end
