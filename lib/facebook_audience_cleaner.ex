defmodule FacebookAudienceCleaner do
  require AdSets

  def clean do
    AdSets.get_adsets
    |> AdSets.extract_audiences
    |> IO.inspect
  end
end
