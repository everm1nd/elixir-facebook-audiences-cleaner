defmodule FacebookAudienceCleaner do
  require AdSets
  require Audiences

  def clean do
    audiences_in_use =
      AdSets.get_adsets
      |> AdSets.extract_audiences
      |> get_ids
      |> Enum.uniq
    all_audiences =
      Audiences.get_audiences
      |> get_ids
      |> Enum.uniq
    non_used_audiences = all_audiences -- audiences_in_use
    IO.puts "Found #{audiences_in_use |> Enum.count} audiences in use"
    IO.puts "Found #{all_audiences |> Enum.count} audiences total"
    IO.puts "#{non_used_audiences |> Enum.count} audiences are not in use"
    IO.puts "Printing IDs of not used audiences:"
    print_ids(non_used_audiences)
  end

  def get_ids(elements) do
    Enum.map(elements, &(&1[:id]))
  end

  def print_ids(elements) do
    Enum.each(elements, &IO.puts(&1))
  end
end
