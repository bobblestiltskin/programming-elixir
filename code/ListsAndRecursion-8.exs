defmodule Orders do
  defp sales_tax(order, tax_rates) do
    [{_, _}, {_, ship_to}, {_, net_amount}] = order
    if rate = tax_rates[ship_to] do
      total_amount = (1 + rate) * net_amount
      order ++ [total_amount: total_amount]
    else
      order
    end
  end

  def add_sales_tax(orders, tax_rates)  do
    for order <- orders, do: {sales_tax(order, tax_rates)}
  end
end
