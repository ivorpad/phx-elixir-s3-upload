defmodule ApiUploader.Repo.Migrations.CreateUploads do
  use Ecto.Migration

  def change do
    create table(:uploads) do
      add :url, :string

      timestamps()
    end
  end
end
