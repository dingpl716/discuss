defmodule Discuss.Plugs.RequireAuth do
  @moduledoc """
  This is another module plug. This plug is designed to be executed before some specific actions.
  """
  import Plug.Conn
  import Phoenix.Controller

  alias Discuss.Router.Helpers

  def init(_) do
  end

  def call(conn, _) do
    if conn.assigns[:user] do
      conn
    else
      conn
      |> put_flash(:error, "You must be logged in.")
      |> redirect(to: Helpers.topic_path(conn, :index))
      # Stop the request pipeline
      |> halt()
    end
  end
end
