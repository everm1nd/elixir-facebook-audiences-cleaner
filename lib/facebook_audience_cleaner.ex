defmodule FacebookAudienceCleaner do
  def clean do
    start
    adsets.body
    |> IO.inspect
  end

  defp start do
    HTTPotion.start
  end

  defp adsets do
    HTTPotion.get adsets_url(ad_account_id), query: adsets_params
  end

  defp adsets_params do
    Map.merge(default_params, %{
      fields: "targeting"
    })
  end

  defp default_params do
    %{
      access_token: access_token
    }
  end

  defp adsets_url(ad_account_id) do
     "https://graph.facebook.com/v2.9/act_#{ad_account_id}/adsets"
  end

  defp ad_account_id do
    System.get_env("AD_ACCOUNT_ID")
  end

  defp access_token do
    System.get_env("ACCESS_TOKEN")
  end
end
