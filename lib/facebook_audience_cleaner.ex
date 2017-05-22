defmodule FacebookAudienceCleaner do
  require AdSets
  require Audiences

  def clean do
    AdSets.get_adsets
    |> AdSets.extract_audiences
    |> IO.inspect
    Audiences.get_audiences
    |> IO.inspect
  end
end
