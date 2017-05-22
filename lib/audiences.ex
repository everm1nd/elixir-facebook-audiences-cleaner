defmodule Audiences do
  import FacebookApi

  def get_audiences do
    FacebookApi.get audiences_url, default_params
  end

  defp audiences_url do
     FacebookApi.base_url <> "/customaudiences"
  end
end
