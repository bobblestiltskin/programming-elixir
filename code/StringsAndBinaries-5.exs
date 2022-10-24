defmodule MyString do
  def centre(mylist) do
    longest = get_longest(mylist, 0)
    _centre(mylist, longest)
  end
  defp get_longest([], longest), do: longest
  defp get_longest(list, longest) do
    [hd|tl] = list
    hlen= String.length(hd)
    if hlen > longest do
      get_longest(tl, hlen)
    else
      get_longest(tl, longest)
    end
  end
  defp _centre([], _), do: :ok
  defp _centre(list, longest) do
    [hd|tl] = list
    hlen= String.length(hd)
    diff = longest - hlen
    lpad = Integer.floor_div(diff, 2)
    tpad = diff - lpad
    IO.puts(String.pad_trailing(String.pad_leading(hd, longest - tpad), longest))
    _centre(tl, longest)
  end
end
