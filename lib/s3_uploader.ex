defmodule S3Uploader do
  alias ExAws.S3.Upload
  alias ExAws.S3
  import UrlParser, only: [extract_filename_from_url: 1]

  require HTTPoison

  def upload_from_url(url, bucket_name) do
    {:ok, file_path} = url |> download_file |> upload_to_s3(bucket_name)

    File.rm!(file_path)
    :ok
  end

  defp download_file(url) do
    {:ok, %HTTPoison.Response{body: body}} = HTTPoison.get(url)

    s3_path = url |> extract_filename_from_url

    # Get the system's temporary directory
    tmp_dir =
      case :os.type() do
        {:win32, _} -> System.get_env("TEMP")
        _ -> System.get_env("TMPDIR") || "/tmp"
      end

    file_path = "#{tmp_dir}/#{s3_path}.zip"

    File.write!(file_path, body)
    { file_path, s3_path }
  end

  defp upload_to_s3({ file_path, s3_path }, bucket_name) do
    # Stream the file
    file_path
      |> Upload.stream_file
      |> S3.upload(bucket_name, s3_path)
      |> ExAws.request!()

    {:ok, file_path}
  end
end
