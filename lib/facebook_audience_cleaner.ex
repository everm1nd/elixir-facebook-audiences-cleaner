defmodule FacebookAudienceCleaner do
  require AdSets

  def clean do
    start
    AdSets.get
    |> IO.inspect
  end

  defp start do
    HTTPotion.start
  end
end
