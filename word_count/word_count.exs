filename = IO.gets("File to read:")
           |> String.trim()

# ! will make it crash if it can't read the file. Split on non word, new line, and \n.
words = filename
        |> File.read!
        |> String.split(
             ~r{(\\n|[^\w'])+}
           )
        |> Enum.filter(fn word -> word != "" end)

#concat String with count of words with string interpolatation and pass to IO.puts
"Count of words: " <> "#{Enum.count(words)}"
|> IO.puts
