defmodule Audiences do
  import FacebookApi
  import FacebookApiConfig

  def get_audiences do
    FacebookApi.get audiences_url(ad_account_id), default_params
  end

  defp audiences_url(ad_account_id) do
     "https://graph.facebook.com/v2.9/act_#{ad_account_id}/customaudiences"
  end
end
