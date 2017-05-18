defmodule AdSets do
  import FacebookApi
  import FacebookApiConfig

  def get do
    adsets.body
    |> parse
    |> fetch_data
    |> get_audiences
  end

  defp adsets do
    HTTPotion.get adsets_url(ad_account_id), query: adsets_params
  end

  defp adsets_params do
    Map.merge(default_params, %{
      fields: "targeting"
    })
  end

  defp adsets_url(ad_account_id) do
     "https://graph.facebook.com/v2.9/act_#{ad_account_id}/adsets"
  end

  defp get_audiences(ad_sets) do
    Enum.map(ad_sets, fn(ad_set) ->
      get_custom_audiences(ad_set) ++ get_excluded_custom_audiences(ad_set)
    end)
  end

  defp get_custom_audiences(ad_set) do
    ad_set[:targeting][:custom_audiences] || []
  end

  defp get_excluded_custom_audiences(ad_set) do
    ad_set[:targeting][:excluded_custom_audiences] || []
  end
end
