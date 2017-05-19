defmodule FacebookAudienceCleaner do
  require AdSets

  def clean do
    start
    AdSets.get_adsets
    |> AdSets.extract_audiences
    |> IO.inspect
  end

  defp start do
    HTTPotion.start
  end
end
