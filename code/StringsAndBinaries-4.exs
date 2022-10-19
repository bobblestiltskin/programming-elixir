defmodule Parse do
  def calculate(sqstring) do
    _calc(sqstring, [], '', [])
  end
  def _calc(sqs, n1, op, n2) when sqs == [] do
#    IO.inspect(n1, label: "n1")
#    IO.inspect(n2, label: "n2")
    num1 = _number_digits(n1, 0)
    num2 = _number_digits(n2, 0)
#    IO.inspect(num1, label: "num1")
#    IO.inspect(num2, label: "num2")
    case op do
      ?+ -> num1 + num2
      ?- -> num1 - num2
      ?* -> num1 * num2
      ?/ -> num1 / num2
    end
  end
  def _calc(sqs, n1, op, n2) when op == '' do
    [hd1|tl1] = sqs
    cond do
      hd1 <= ?9 and hd1 >= ?0 ->
        n1 = n1 ++ [hd1]
        _calc(tl1, n1, op, n2)
      hd1 == ?\s -> # hd1 is a space
        [hd2|tl2] = tl1
        op = hd2
        [hd3|tl3] = tl2
        case hd3 do
          ?\s -> _calc([], n1, op, tl3)
          _ -> _calc([], n1, op, tl2)
        end
      true -> # must be an operator
        op = hd1
        [hd2|tl2] = tl1
        case hd2 do
          ?\s -> _calc([], n1, op, tl2)
          _ -> _calc([], n1, op, tl1)
        end
    end
  end
  defp _number_digits([], value), do: value
  defp _number_digits([ digit | tail ], value) when digit in '0123456789' do
    _number_digits(tail, value*10 + digit - ?0)
  end
  defp _number_digits([ non_digit | _ ], _) do
    raise "Invalid digit '#{[non_digit]}'"
  end
end
