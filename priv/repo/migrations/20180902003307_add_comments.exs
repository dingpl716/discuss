defmodule Discuss.Repo.Migrations.AddComments do
  use Ecto.Migration

  def change do
    create table(:comments) do
      add(:conent, :string)
      add(:user_id, references(:users))
      add(:topic_id, references(:topics))
      timestamps()
    end
  end
end
