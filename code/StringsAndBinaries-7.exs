defmodule MyFile do
  def read_data(filename) do
    {:ok, file} = File.open(filename)
    _header = IO.read(file, :line)
#    IO.inspect(header, label: "header")
    Enum.each(IO.stream(file, :line), &parse_line(&1))
  end
  def parse_line(line) do
    [id, ship_to, net_amount] = line
    |> String.trim()
    |> String.split(",")
    tax_rates = [ NC: 0.075, TX: 0.08 ]
    order = [id: String.to_integer(id), ship_to: String.to_atom(String.trim(ship_to, ":")), net_amount: String.to_float(net_amount)]
    IO.inspect(Orders.sales_tax(order, tax_rates))
  end
end

defmodule Orders do
  def sales_tax(order, tax_rates) do
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
