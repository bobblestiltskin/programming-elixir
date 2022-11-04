defmodule Retval do
  def ok!(input) do
    case input do
      {:ok, data} ->
        data
      _ ->
#        IO.inspect(input)
        raise "Bad input : #{inspect(input)}"
    end
  end
end
