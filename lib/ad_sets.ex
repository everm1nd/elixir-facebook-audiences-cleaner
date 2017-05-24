defmodule AdSets do
  import FacebookApi
  import FacebookApiConfig

  def get_adsets do
    FacebookApi.get adsets_url, adsets_params
  end

  def extract_audiences(ad_sets) do
    Enum.map(ad_sets, &(get_custom_audiences(&1) ++ get_excluded_custom_audiences(&1)))
    |> List.flatten
  end

  defp adsets_params do
    Map.merge(default_params, %{
      fields: "targeting"
    })
  end

  defp adsets_url do
     FacebookApi.ad_account_url <> "/adsets"
  end

  defp get_custom_audiences(ad_set) do
    ad_set[:targeting][:custom_audiences] || []
  end

  defp get_excluded_custom_audiences(ad_set) do
    ad_set[:targeting][:excluded_custom_audiences] || []
  end
end
