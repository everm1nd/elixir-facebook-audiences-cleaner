defmodule FacebookApiConfig do
  def ad_account_id do
    System.get_env("AD_ACCOUNT_ID")
  end

  def access_token do
    System.get_env("ACCESS_TOKEN")
  end
end
