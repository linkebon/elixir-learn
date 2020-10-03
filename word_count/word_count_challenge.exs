defmodule Util do
  def read_type_to_parse() do
    case "numbers or words: "
         |> IO.gets
         |> String.trim do
      "numbers" ->
        ~r{[0-9]+}
      "words" ->
        ~r{[^\w]+}
      _ ->
        "Valid input is: numbers or words"
        |> IO.puts
        read_type_to_parse()
    end
  end
end
#words numbers or new lines
type_to_parse_regexp = Util.read_type_to_parse()

filename = IO.gets("File to read:")
           |> String.trim()

# ! will make it crash if it can't read the file. Split on non word, new line, and \n.
words = filename
        |> File.read!()
        |> String.split(
             type_to_parse_regexp
           ) # file will be passed to split as first arguement and rest of params and 2nd 3rd etc
        |> Enum.filter(fn word -> word != "" end)

#concat String with count of words with string interpolatation and pass to IO.puts
"Count of words: " <> "#{Enum.count(words)}"
|> IO.puts()