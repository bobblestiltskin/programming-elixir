defmodule MyString do
  def capitalise(string) do
    string
    |> String.split(". ")
    |> _capitalise("")
  end
  defp _capitalise(list, out) do
    [hd|tl] = list
    if tl == [] do
      out
    else
      _capitalise(tl, out <> String.capitalize(hd) <> ". ")
    end
  end
end
