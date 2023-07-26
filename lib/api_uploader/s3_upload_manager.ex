defmodule ApiUploader.S3UploaderManager do
  use GenServer
  import S3Uploader, only: [upload_from_url: 2]

  # GenServer API
  def start_link(_) do
    GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(:ok) do
    {:ok, %{}}
  end

  def handle_call(:get_data, _from, state) do
    {:reply, state, state}
  end

  def handle_cast(prev_state, _state) do
    %{"bucket" => bucket, "url" => url} = prev_state
    new_state = upload_from_url(url, bucket)
    {:noreply, new_state}
  end
end
