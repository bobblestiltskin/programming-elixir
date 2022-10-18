defmodule MyList do
  def flatten([]) do
    []
  end
  def flatten([head | tail]) do
    Enum.reverse(_flatten(head, tail, []))
  end
  def _flatten(item, [], output) when is_list(item) do
    [h|t] = item
    _flatten(h, t, output)
  end
  def _flatten(item, [], output) do
    [item] ++ output
  end
  def _flatten(head, tail, output) when is_list(head) do
    [h|t] = tail
    _flatten(h, t, Enum.reverse(flatten(head)) ++ output)
  end
  def _flatten(head, tail, output) do
    [h|t] = tail
    _flatten(h, t, [head] ++ output)
  end
end
