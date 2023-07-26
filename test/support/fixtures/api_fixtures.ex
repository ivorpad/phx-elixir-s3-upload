defmodule ApiUploader.APIFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ApiUploader.API` context.
  """

  @doc """
  Generate a upload.
  """
  def upload_fixture(attrs \\ %{}) do
    {:ok, upload} =
      attrs
      |> Enum.into(%{
        url: "some url"
      })
      |> ApiUploader.API.create_upload()

    upload
  end
end
