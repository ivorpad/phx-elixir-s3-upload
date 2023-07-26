defmodule ApiUploader.APITest do
  use ApiUploader.DataCase

  alias ApiUploader.API

  describe "uploads" do
    alias ApiUploader.API.Upload

    import ApiUploader.APIFixtures

    @invalid_attrs %{url: nil}

    test "list_uploads/0 returns all uploads" do
      upload = upload_fixture()
      assert API.list_uploads() == [upload]
    end

    test "get_upload!/1 returns the upload with given id" do
      upload = upload_fixture()
      assert API.get_upload!(upload.id) == upload
    end

    test "create_upload/1 with valid data creates a upload" do
      valid_attrs = %{url: "some url"}

      assert {:ok, %Upload{} = upload} = API.create_upload(valid_attrs)
      assert upload.url == "some url"
    end

    test "create_upload/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = API.create_upload(@invalid_attrs)
    end

    test "update_upload/2 with valid data updates the upload" do
      upload = upload_fixture()
      update_attrs = %{url: "some updated url"}

      assert {:ok, %Upload{} = upload} = API.update_upload(upload, update_attrs)
      assert upload.url == "some updated url"
    end

    test "update_upload/2 with invalid data returns error changeset" do
      upload = upload_fixture()
      assert {:error, %Ecto.Changeset{}} = API.update_upload(upload, @invalid_attrs)
      assert upload == API.get_upload!(upload.id)
    end

    test "delete_upload/1 deletes the upload" do
      upload = upload_fixture()
      assert {:ok, %Upload{}} = API.delete_upload(upload)
      assert_raise Ecto.NoResultsError, fn -> API.get_upload!(upload.id) end
    end

    test "change_upload/1 returns a upload changeset" do
      upload = upload_fixture()
      assert %Ecto.Changeset{} = API.change_upload(upload)
    end
  end
end
