iex(2)> prefix = fn first -> (fn second -> "#{first} #{second}" end) end
#Function<44.79398840/1 in :erl_eval.expr/5>
iex(3)> 
