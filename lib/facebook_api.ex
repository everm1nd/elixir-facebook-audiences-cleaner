defmodule FacebookApi do
  import FacebookApiConfig

  def default_params do
    %{
      access_token: access_token,
      limit: 250
    }
  end

  def base_url do
    "https://graph.facebook.com/v2.9/act_#{ad_account_id}"
  end

  def get(resource_url, params) do
    get_resource([], request(resource_url, params))
  end

  defp get_resource(acc, response = %{data: data, paging: %{next: next_url}}) do
    log_progress response
    get_resource(data ++ acc, request(next_url))
  end

  defp get_resource(acc, response = %{data: data}) do
    log_progress response
    data ++ acc
  end

  defp request(url, params \\ %{}) do
    (Tesla.get url, query: params).body |> parse
  end

  defp parse(response_body) do
    Poison.Parser.parse! response_body, keys: :atoms
  end

  defp log_progress(%{paging: %{cursors: %{after: after_cursor}}}) do
    IO.puts "got block #{after_cursor}"
  end
end
