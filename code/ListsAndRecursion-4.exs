defmodule MyList do
  def span(from, to) do
    span_list(from, to, [])
  end

  def span_list(from, to, list) when from > to do
#    Enum.reverse(list)
    list
  end

  def span_list(from, to, list) do
#    span_list(from + 1, to, [from] ++ list)
    span_list(from + 1, to, list ++ [from])
  end
end



