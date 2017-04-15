defmodule Manager.Repo.Migrations.CreateElement do
  use Ecto.Migration

  def change do
    create table(:elements, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :body, :text
      add :group_id, references(:groups, on_delete: :nothing, type: :binary_id)
      add :element_id, references(:elements, on_delete: :nothing, type: :binary_id), null: true

      timestamps()
    end
    create index(:elements, [:group_id])

  end
end
