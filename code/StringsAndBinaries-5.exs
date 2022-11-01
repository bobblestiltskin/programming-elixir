defmodule MyString do
  def centre(mylist) do
    longest = get_longest(mylist, 0)
    output = _centre(mylist, longest, [])
    printl(output)
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
  defp _centre(list, longest, output) do
    [hd|tl] = list
    hlen= String.length(hd)
    diff = longest - hlen
    lpad = Integer.floor_div(diff, 2)
    tpad = diff - lpad
    if tl == [] do
      output = output ++ [hd]
    else
      ostring = String.pad_trailing(String.pad_leading(hd, longest - tpad), longest)
      output = output ++ [ostring]
      _centre(tl, longest, output)
    end
  end
  defp printl(list) do
    [hd|tl] = list
    IO.inspect(hd)
    if tl != [] do
      printl(tl)
    end
  end
end
