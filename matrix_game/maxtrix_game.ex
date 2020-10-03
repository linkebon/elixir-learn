# 11 12 13 14 15
# 21 22 23 24 25
# 31 32 33 34 35
# 41 42 43 44 45
# 51 52 53 54 55

defmodule MatrixGame do
  def start() do
    rows = IO.gets("Rows: ")
           |> String.trim()
           |> String.to_integer()

    columns = IO.gets("Columns: ")
              |> String.trim()
              |> String.to_integer()
    generate_new_game_plan(rows, columns)
  end

  def generate_new_game_plan(rows, columns, remove_value \\ -1) do

    game_plan = for(
      row <- 0..(rows - 1),
      should_generate(row, remove_value),
      do: Enum.to_list(first_value_in_row(row)..last_value_in_row(row, columns, remove_value))
    )

    case game_over(game_plan) do
      true -> IO.puts("You LOST!")
      false ->
        print_board(game_plan)
        value_to_remove = IO.gets("Print number to remove: ")
        |> String.trim()
        |> String.to_integer()
        generate_new_game_plan(rows, columns, value_to_remove)
    end

  end

  def game_over(game_plan), do: length(game_plan) == 0

  def should_generate(current_row, remove_value) when remove_value == -1, do: true

  def should_generate(current_row, remove_value) do
    # dont generate any rows after last_values row if the last value is in the first column
    !(getCol(remove_value) == 1 && current_row >= getRow(remove_value))
  end

  def first_value_in_row(n), do: ((n + 1) * 10) + 1

  def last_value_in_row(current_row, columns, remove_value) when remove_value == -1,
      do: first_value_in_row(current_row) + columns - 1

  def last_value_in_row(current_row, columns, remove_value) do
    if(getRow(remove_value) == current_row) do
      remove_value - 1 # give back one less then the last number for same row
    else
      if(getRow(remove_value) < current_row) do
        # generate numbers for the rows after remove_value row up to the column before remove_value column
        ((current_row + 1) * 10) + getCol(remove_value) - 1
      else
        first_value_in_row(current_row) + columns - 1
      end
    end
  end

  def getRow(val), do: div(val, 10) - 1

  def getCol(val), do: rem(val, 10)

  def print_board(board) do
    Enum.each(
      board,
      fn (row) -> Enum.join(row, " ")
                  |> IO.puts()
      end
    )
  end
end
