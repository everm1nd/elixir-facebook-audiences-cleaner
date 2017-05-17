defmodule Mix.Tasks.CleanAudiences do
  use Mix.Task

  def run(_) do
     FacebookAudienceCleaner.clean |> IO.inspect
  end
end
