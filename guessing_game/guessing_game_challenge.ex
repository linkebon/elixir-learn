#alchemist.camp guessing_game challenge
defmodule GuessingName do

  def greet do
    case String.trim(IO.gets "Hi, there what is your name? \n") do
      "Staffan" -> "wooow, amazing. I was programmed by him"
      other -> ~s{Hello there, #{other}}
    end
  end

end