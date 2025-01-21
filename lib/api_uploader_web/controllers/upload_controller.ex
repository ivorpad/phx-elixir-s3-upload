defmodule ApiUploaderWeb.UploadController do
  use ApiUploaderWeb, :controller

  def create(conn, %{"url" => url, "bucket" => bucket} = params)
      when is_binary(url) and is_binary(bucket) do
    api_key = System.get_env("API_KEY")

    case get_req_header(conn, "authorization") do
      [authorization] when authorization == api_key ->
        pid = Process.whereis(ApiUploader.S3UploaderManager)
        GenServer.cast(pid, %{"url" => url, "bucket" => bucket})
        json(conn, %{message: "Successfully processed the URL"})

      _ ->
        json(conn, %{error: "Authorization header is missing or invalid"})
    end
  end

  def create(conn, _params) do
    json(conn, %{error: "URL or bucket parameter is missing"})
  end

  def options(conn, _params) do
    conn
    |> put_resp_header("access-control-allow-methods", "GET, POST, OPTIONS")
    |> put_resp_header("access-control-allow-headers", "Authorization, Content-Type")
    |> send_resp(:no_content, "")
  end
end
