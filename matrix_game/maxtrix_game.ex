# Matrix game
# Play creating a matrix by defining amount of rows and columns the game field should have
# Then each player removes values by providing a number on the game field.
# The player that removes the last element loose before the game field.

# Game field generated by 9 rows and 9 columns below.
#Game field
#---------------
#11 12 13 14 15 16 17 18 19
#21 22 23 24 25 26 27 28 29
#31 32 33 34 35 36 37 38 39
#41 42 43 44 45 46 47 48 49
#51 52 53 54 55 56 57 58 59
#61 62 63 64 65 66 67 68 69
#71 72 73 74 75 76 77 78 79
#81 82 83 84 85 86 87 88 89
#91 92 93 94 95 96 97 98 99
#---------------
defmodule MatrixGame do
  def start() do
    rows = IO.gets("Rows[Max 9]: ")
           |> String.trim()
           |> String.to_integer()

    columns = IO.gets("Columns[Max 9]: ")
              |> String.trim()
              |> String.to_integer()

    if(rows > 9 || columns > 9) do
      IO.puts("Max 9 rows and max 9 columns")
      start()
    end
    game_field = generate_game_field(rows, columns)
    print_game_field(game_field)
    current_player = which_players_turn?("none")
    IO.puts("#{current_player} starts")
    next_turn(game_field, current_player)
  end

  def next_turn(game_field, current_player) do
    remove_val = read_remove_val(game_field)
    new_game_field =
      Enum.map(
        game_field,
        fn row -> Enum.map(
                    row,
                    fn current_val -> if(should_value_be_removed?(current_val, remove_val)) do
                                        -1
                                      else
                                        current_val
                                      end
                    end
                  )
        end
      )
    if(game_over?(new_game_field)) do
      IO.puts("Game over! #{which_players_turn?(current_player)} WON!!! \n#{current_player} took the last element and therefore lost!")
    else
      print_game_field(new_game_field)
      next_player = which_players_turn?(current_player)
      IO.puts("#{next_player}'s turn!")
      next_turn(new_game_field, which_players_turn?(current_player))
    end
  end

  def read_remove_val(game_field) do
    case IO.gets("Print number to remove: ")
         |> String.trim()
         |> Integer.parse() do
      {parsed, _} ->
        if(number_exist_in_game_field?(game_field, parsed)) do
          parsed
        else
          IO.puts("Number did not exist in game field.. Try again \n")
          read_remove_val(game_field)
        end
      :error ->
        IO.puts("You did not provide a number.. Try again \n")
        read_remove_val(game_field)
    end
  end

  def number_exist_in_game_field?(game_field, number),
      do: game_field
          |> Enum.any?(fn row -> number in row end)

  def which_players_turn?(current_player) do
    case current_player do
      "Player 1" -> "Player 2"
      "Player 2" -> "Player 1"
      _ -> "Player 1"
    end
  end

  def generate_game_field(rows, columns),
      do: for(
        row <- 0..(rows - 1),
        do: Enum.to_list(first_value_in_row(row)..last_value_in_row(row, columns))
      )

  def print_game_field(game_field) do
    IO.puts("\nGame field \n---------------")
    Enum.each(
      game_field,
      fn (row) -> Enum.join(row, " ")
                  |> String.replace("-1", " ")
                  |> IO.puts()
      end
    )
    IO.puts("---------------")
  end

  def should_value_be_removed?(current_val, remove_val) do
    current_val_row = getRow(current_val)
    current_val_col = getCol(current_val)
    remove_val_row = getRow(remove_val)
    remove_val_col = getCol(remove_val)

    case current_val do
      x when current_val_row == remove_val_row and x >= remove_val -> true
      x when remove_val_row < current_val_row
             and current_val_col >= remove_val_col
             and x >= remove_val -> true
      _ -> false
    end
  end

  def game_over?(game_field),
      do: Enum.all?(
        game_field,
        fn row ->
          Enum.all?(
            row,
            fn val -> val == -1 end
          )
        end
      )

  def first_value_in_row(n), do: ((n + 1) * 10) + 1

  def last_value_in_row(current_row, columns), do: first_value_in_row(current_row) + columns - 1

  def getRow(val), do: div(val, 10) - 1

  def getCol(val), do: rem(val, 10)
end