defmodule Fizz do
  def buzz(n) when n > 0 do
    1..n |> Enum.map(&_fb/1)
  end
    
  defp _fb(n) do
    s = %{div3: rem(n,3) == 0, div5: rem(n, 5) == 0}
    case s do
      %{div3: true, div5: true} ->
        "FizzBuzz"
      %{div3: true, div5: false} ->
        "Fizz"
      %{div3: false, div5: true} ->
        "Buzz"
      _ ->
        n
    end
  end
end
