defmodule Discuss.Comment do
  use Discuss.Web, :model

  alias Discuss.User
  alias Discuss.Topic

  schema "comments" do
    field(:conent, :string)
    belongs_to(:user, User)
    belongs_to(:topic, Topic)
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:content])
    |> validate_required([:content])
  end
end
