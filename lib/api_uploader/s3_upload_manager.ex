defmodule ApiUploader.S3UploaderManager do
  use GenServer
  import S3Uploader, only: [upload_from_url: 1]

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

  def handle_cast(url, state) do
    new_state = upload_from_url(url)
    {:noreply, new_state}
  end
end
