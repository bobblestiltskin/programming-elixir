defmodule MyList do
  def span(from, to) do
    span_list(from, to, [])
  end

  defp span_list(from, to, list) when from > to do
    list
  end

  defp span_list(from, to, list) do
    span_list(from + 1, to, list ++ [from])
  end

  defp is_prime(x) do
    potential_divisors = span(2, x - 1)
    divisors = for d <- potential_divisors, rem(x,d) == 0, do: d
    case divisors do
      [] -> true
      _  -> false
    end
  end

  def primes(n) do
    divisors = span(2, n - 1)
    span = divisors ++ [n]
    for x <- span, is_prime(x), do: x
  end
end
