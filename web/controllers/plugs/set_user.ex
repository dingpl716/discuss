defmodule Discuss.Plugs.SetUser do
  @moduledoc """
  This pulg is function plug. It runs for every request.
  """
  import Plug.Conn
  import Phoenix.Controller

  alias Discuss.{Repo, User, Router.Helpers}

  @doc """
  This is the place where you should put those heavy perations like pull a
  lot of data from DB.
  """
  def init(_) do
  end

  @doc """
  To look at the `conn` object, to see if there is a user_id assigned to
  it. If yes, then pull the user object from db and assign back to conn.

  This _params is not like the second input argument in controller,
  it is the return value of init method above.
  """
  def call(conn, _params) do
    user_id = get_session(conn, :user_id)

    cond do
      user = user_id && Repo.get(User, user_id) ->
        assign(conn, :user, user)

      true ->
        assign(conn, :user, nil)
    end
  end
end
