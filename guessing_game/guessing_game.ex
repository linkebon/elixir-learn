# run game
# open terminal
# type: iex
# c "guessing_game.ex"
# GuessingGame.guess 1, 100

defmodule GuessingGame do
  def guess(a, b) when a > b, do: guess(b, a)

  def guess(low, high) do
    answer = IO.gets "Maybe your thinking of: #{mid(low, high)}\n"

    case String.trim(answer) do
      "bigger" -> bigger(low, high)
      "smaller" -> smaller(low, high)
      "yes" -> "i knew it!"
      _ ->
        IO.puts ~s{Type "bigger", "smaller" or "yes"}
        guess(low, high)
    end
  end

  def mid(low, high) do
    div low + high, 2
  end

  def bigger(low, high) do
    new_low = min(high, mid(low, high) + 1)
    guess(new_low, high)
  end

  def smaller(low, high) do
    new_high = max(low, mid(low, high) - 1)
    guess low, new_high
  end
end