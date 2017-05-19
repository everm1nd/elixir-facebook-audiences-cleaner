defmodule FacebookApi do
  import FacebookApiConfig

  def default_params do
    %{
      access_token: access_token
    }
  end

  def parse(response_body) do
    Poison.Parser.parse! response_body, keys: :atoms
  end

  def get_response_data(%{data: data}) do
    data
  end

  def get_resource(acc, response = %{data: data, paging: %{next: next_url}}) do
    log_progress response
    get_resource(data ++ acc, request(next_url))
  end

  def get_resource(acc, response = %{data: data}) do
    log_progress response
    data ++ acc
  end

  def request(url, params \\ %{}) do
    (HTTPotion.get url, query: params).body |> parse
  end

  def log_progress(%{paging: %{cursors: %{after: after_cursor}}}) do
    IO.puts "got block #{after_cursor}"
  end
end
