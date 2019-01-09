defmodule Discuss.CommentsChannel do
  @moduledoc """
  Every channel module needs to have two functions defined, join and handle_in

  join -- Called everytime when a client wants to join a channel
  """

  use Discuss.Web, :channel

  def join(topic, _params, socket) do
    IO.inspect(binding())

    # The map in the middle is the data that we are returning back to client.
    {:ok, %{hey: "there"}, socket}
  end

  @doc """
  The second parameter, message, is sent from client
  """
  def handle_in(topic, message, socket) do
    IO.inspect(binding())
    {:reply, :ok, socket}
  end
end
