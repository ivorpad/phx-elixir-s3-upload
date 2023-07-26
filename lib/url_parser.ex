defmodule UrlParser do
  def extract_filename_from_url(url) do
    %{ query: query } = URI.parse(url)

    URI.decode_query(query)
      |> Map.get("response-content-disposition")
      |> String.split(";")
      |> Enum.map(&String.trim/1)
      |> Enum.find(&String.starts_with?(&1, "filename="))
      |> String.replace("filename=", "")
  end
end
