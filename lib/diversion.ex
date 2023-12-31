defmodule Diversion do
  require Logger

  def wander(bits) do
    max_number = 
      build_max(bits, [1])
      |> Enum.join("")
      |> String.to_integer(2)

    tries = 
      for indice <- 2..max_number do
        Logger.debug("testing #{indice} next -> ")
        diverseN(indice)
      end

    Logger.debug("these are the results/tries : \n#{inspect tries}")

    valids =
      tries 
      |> Enum.reject(fn x -> :err in x end)  


    traverse_back(valids)

  end

  defp traverse_back(valids) do
    valids
    |> Enum.map(
      fn value -> 
        number = 
          value
          |> Enum.join("")

        %{binary: String.to_integer(number, 10), decimal: String.to_integer(number, 2)} 
    end)
  end

  defp build_max(bits, list) do
    case bits do
      1 -> list
      _ -> list ++ build_max(bits-1, list)
    end
  end


  def diverseN(n) do
      n
      |> Integer.to_string(2)
      |> String.split("", trim: true)
      #|> Enum.chunk_every(2, 1, :discard)
    #|> Enum.map(&check_neighbours(&1)) 
    #  |> List.flatten()
  end

  defp check_neighbours(["1", "1"]) do
    :err
  end

  defp check_neighbours([a, b]) do
    case a == b == 1 do
      true -> Logger.debug("ERROROROROR")
      _ -> 
        [a, b]
    end
  end

end
