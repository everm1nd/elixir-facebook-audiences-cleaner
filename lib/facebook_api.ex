defmodule FacebookApi do
  import FacebookApiConfig

  def default_params do
    Map.merge(auth_params, %{
      limit: 250
    })
  end

  def auth_params do
    %{
      access_token: access_token
    }
  end

  def ad_account_url do
    base_url <> "/act_#{ad_account_id}"
  end

  def audience_url(custom_audience_id) do
    base_url <> "/#{custom_audience_id}"
  end

  defp base_url do
    "https://graph.facebook.com/v2.9"
  end

  def get(resource_url, params) do
    get_resource([], request(resource_url, params))
  end

  def delete(resource_url, params) do
    request(resource_url, params, :delete)
  end

  defp get_resource(acc, response = %{data: data, paging: %{next: next_url}}) do
    log_progress response
    get_resource(data ++ acc, request(next_url))
  end

  defp get_resource(acc, response = %{data: data}) do
    log_progress response
    data ++ acc
  end

  defp request(url, params \\ %{}, method \\ :get) do
    request_method = case method do
      :get ->
        &(Tesla.get/2)
      :delete ->
        &(Tesla.delete/2)
    end
    request_method.(url, query: params).body |> parse
  end

  defp parse(response_body) do
    Poison.Parser.parse! response_body, keys: :atoms
  end

  defp log_progress(%{paging: %{cursors: %{after: after_cursor}}}) do
    IO.puts "got block #{after_cursor}"
  end
end
