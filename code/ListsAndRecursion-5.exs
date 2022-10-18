defmodule MyEnum do
  def all?([]), do: true
  def all?([h|t]) do
    if h == false do
      false
    else
      all?(t)
    end
  end

  def each([], _f), do: :ok
  def each([h|t], f) do
    f.(h)
    each(t, f)
  end

  def filter([], _f), do: []
  def filter([h|t], f) do
    _filter([h|t], f, [])
  end
  def _filter([], _f, output), do: output
  def _filter([h|t], f, output) do
    if f.(h) do
      _filter(t, f, output ++ [h])
    else
      _filter(t, f, output)
    end
  end

  def split(range, count) do
    if count < 0 do
      rev_split(range, -count)
    else
      _split(range, count, [])
    end
  end
  def _split(range, 0, list) do
    {list, Enum.to_list(range)}
  end
  def _split(range, count, list) do
    first .. last = range
    if count > last - first + 1 do
      {Enum.to_list(range), []}
    else
      _split(first + 1 .. last, count - 1, list ++ [first])
    end
  end
  def rev_split(range, count) do
    _rev_split(range, count, [])
  end
  def _rev_split(range, 0, list) do
    {Enum.to_list(range), list}
  end
  def _rev_split(range, count, list) do
    first .. last = range
    _rev_split(first .. last - 1, count - 1, [last] ++ list)
  end

  def take(range, count) do
    if count < 0 do
      rev_take(range, -count)
    else
      _take(range, count, [])
    end
  end
  def _take([], _, _list) do
    []
  end
  def _take(_range, 0, list) do
    list
  end
  def _take(range, count, list) do
    first .. last = range
    if count > last - first + 1 do
      Enum.to_list(range)
    else
      _take(first + 1 .. last, count - 1, list ++ [first])
    end
  end
  def _rev_take([], _, _list) do
    []
  end
  def rev_take(range, count) do
    _rev_take(range, count, [])
  end
  def _rev_take(_range, 0, list) do
    list
  end
  def _rev_take(range, count, list) do
    first .. last = range
    _rev_take(first .. last - 1, count - 1, [last] ++ list)
  end
end 
