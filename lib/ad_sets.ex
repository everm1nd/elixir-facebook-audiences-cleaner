defmodule AdSets do
  import FacebookApi
  import FacebookApiConfig

  def get_adsets do
    response = request adsets_url(ad_account_id), adsets_params
    log_progress response
    get_resource(response[:data], response)
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

  defp adsets_url(ad_account_id) do
     "https://graph.facebook.com/v2.9/act_#{ad_account_id}/adsets"
  end

  defp get_custom_audiences(ad_set) do
    ad_set[:targeting][:custom_audiences] || []
  end

  defp get_excluded_custom_audiences(ad_set) do
    ad_set[:targeting][:excluded_custom_audiences] || []
  end
end
