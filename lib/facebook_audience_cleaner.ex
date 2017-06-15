defmodule FacebookAudienceCleaner do
  require AdSets
  require Audiences
  require Logger

  def clean do
    test_list = [""]
    delete_audiences(test_list) |> IO.inspect
  end

  defp show_audiences do
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
    Logger.info "Found #{all_audiences |> Enum.count} audiences total"
    Logger.info "Found #{audiences_in_use |> Enum.count} audiences in use"
    Logger.info "#{non_used_audiences |> Enum.count} audiences are not in use"
    non_used_audiences
  end

  defp delete_audiences(audiences) do
    Enum.map(audiences, &Audiences.delete(&1))
  end

  defp get_ids(elements) do
    Enum.map(elements, &(&1[:id]))
  end

  defp print(elements) do
    Enum.each(elements, &Logger.info(&1))
  end
end
