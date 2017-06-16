defmodule Audiences do
  import FacebookApi
  require Logger

  @delete_pause 5000

  def get_audiences do
    FacebookApi.get audiences_url, default_params
  end

  def delete(id) do
    :timer.sleep(@delete_pause)
    response = FacebookApi.delete audience_url(id), auth_params
    case response do
      %{success: true} ->
        Logger.info "Deleted audience with ID #{id}"
      %{error: %{code: code, message: message}} ->
        Logger.error "Something went wrong for ID #{id}. Error code: #{code}. Message: \"#{message}\""
    end
  end

  defp audiences_url do
     FacebookApi.ad_account_url <> "/customaudiences"
  end
end
