defmodule FacebookAudienceCleaner do
  def clean do
    HTTPotion.start
    HTTPotion.get "httpbin.org/get"
  end
end
