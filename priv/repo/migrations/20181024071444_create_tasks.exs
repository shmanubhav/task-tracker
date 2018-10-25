defmodule TaskTracker.Repo.Migrations.CreateTasks do
  use Ecto.Migration

  def change do
    create table(:tasks) do
      add :title, :string
      add :description, :text
      add :completed, :boolean, default: false, null: false
      add :user_id, references(:users, on_delete: :delete_all)

      timestamps()
    end

    create index(:tasks, [:user_id])
  end
end
