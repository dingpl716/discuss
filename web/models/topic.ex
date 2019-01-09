defmodule Discuss.Topic do
  alias Discuss.{Comment, User}
  use(Discuss.Web, :model)

  schema("topics") do
    field(:title, :string)
    belongs_to(:user, User)
    has_many(:comments, Comment)
  end

  @doc """
  `Struct`: A hash that contains some data. Represents a record (or a record we
  want to save) in the database.
  `Params`: A hash that contains the properties we want to update the struct with.
  Returns a changeset which knows the data we're trying to save and whether or
  not there are validation issues with it.
  """
  def changeset(struct, params \\ %{}) do
    struct
    # produces a changeset
    |> cast(params, [:title])
    # adds errors to changeset
    |> validate_required([:title])
  end
end
