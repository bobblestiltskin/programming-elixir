defmodule Ring do
  @interval 2000

  def generate(client, next, enabled) do
    receive do
      {:tick, sender} ->
        IO.puts("<#{sender}> sent tick to <#{client}>")
        generate(client, next, true)

      {:register, new} ->
        case next do
          nil -> send(new, {:set_next, self()})
          _ -> send(new, {:set_next, next})
        end

        generate(client, new, enabled)

      {:set_next, new} ->
        generate(client, new, enabled)
    after
      @interval ->
        if enabled and next != nil do
          send(next, {:tick, client})
          generate(client, next, false)
        else
          generate(client, next, enabled)
        end
    end
  end
end
