defmodule Audiences do
  import FacebookApi

  def get_audiences do
    FacebookApi.get audiences_url, default_params
  end

  def delete(id) do
    FacebookApi.delete audience_url(id), auth_params
  end

  defp audiences_url do
     FacebookApi.ad_account_url <> "/customaudiences"
  end
end
