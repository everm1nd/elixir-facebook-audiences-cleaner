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

  def fetch_data(%{data: data}) do
    data
  end
end
