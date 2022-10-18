defmodule MyString do
  def all_printable(input) do
    case input do
      [] -> true
      _ ->
        [head|tail] = input
    
        if head < ?\s or head > ?~ do
          false
        else
          all_printable tail
        end
    end
  end
end
