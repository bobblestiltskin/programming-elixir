defmodule MyString do
  def anagram?(word1, word2) when byte_size(word1) != byte_size(word2), do: false
  def anagram?(word1, _) when byte_size(word1) == 0, do: true
  def anagram?(word1, word2) do
    {first, rest} = String.split_at(word1, 1)
    case String.split(word2, first, parts: 2) do
      [_] -> false
      [split1, split2] ->
        anagram?(rest, split1 <> split2)
    end
  end
end
