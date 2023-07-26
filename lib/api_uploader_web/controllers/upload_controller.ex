defmodule ApiUploaderWeb.UploadController do
  use ApiUploaderWeb, :controller

  def show(conn, _params) do
    json(conn, %{
      AWS_ACCESS_KEY_ID: System.get_env("AWS_ACCESS_KEY_ID"),
      AWS_SECRET_ACCESS_KEY: System.get_env("AWS_SECRET_ACCESS_KEY")
    })
  end

  def create(conn, params) do
    IO.inspect(params)

    case params do
      %{"url" => url, "bucket" => bucket} ->

        pid = Process.whereis(ApiUploader.S3UploaderManager)

        GenServer.cast(pid, %{"url" => url, "bucket" => bucket})

        json(conn, %{message: "Successfully processed the URL"})

      _ ->
        # Handle the missing "url" key here
        json(conn, %{error: "URL parameter is missing"})
    end
  end
end
