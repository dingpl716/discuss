defmodule Discuss.TopicController do
  use(Discuss.Web, :controller)

  alias Discuss.Topic
  alias Discuss.Plugs.RequireAuth

  plug(RequireAuth when action in [:new, :create, :edit, :update, :delete])
  plug(:check_topic_owner when action in [:update, :edit, :delete])

  def show(conn, %{"id" => topic_id}) do
    topic = Repo.get!(Topic, topic_id)
    render(conn, "show.html", topic: topic)
  end

  def index(conn, _params) do
    topics = Repo.all(Topic)
    render(conn, "index.html", topics: topics)
  end

  # 相当于是
  # changeset + form template = usable form
  def new(conn, _params) do
    changeset = Topic.changeset(%Topic{}, %{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"topic" => topic} = params) do
    # The old way to insert a topic when there is no association between a topic and a user
    # changeset = Topic.changeset(%Topic{}, topic)

    changeset =
      conn.assigns.user
      |> build_assoc(:topics)
      |> Topic.changeset(topic)

    case Repo.insert(changeset) do
      {:ok, _topic} ->
        conn
        |> put_flash(:info, "Topic Created")
        |> redirect(to: topic_path(conn, :index))

      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  # 相当于是
  # changeset + topic struct + form template = usable form
  def edit(conn, params) do
    %{"id" => topic_id} = params
    topic = Repo.get(Topic, topic_id)
    changeset = Topic.changeset(topic)
    render(conn, "edit.html", changeset: changeset, topic: topic)
  end

  def update(conn, %{"id" => topic_id, "topic" => new_topic}) do
    # get the existing topic first
    old_topic = Repo.get(Topic, topic_id)
    # then get the changeset from existing topic to new topic
    changeset = Topic.changeset(old_topic, new_topic)

    case Repo.update(changeset) do
      {:ok, _topic} ->
        conn
        |> put_flash(:info, "Topic updated")
        |> redirect(to: topic_path(conn, :index))

      {:error, changeset} ->
        render(conn, "edit.html", changeset: changeset, topic: old_topic)
    end
  end

  def delete(conn, %{"id" => topic_id}) do
    Repo.get!(Topic, topic_id)
    |> Repo.delete!()

    conn
    |> put_flash(:info, "Topic Deleted")
    |> redirect(to: topic_path(conn, :index))
  end

  @doc """
  This is a function module.
  """
  def check_topic_owner(conn, _) do
    %{params: %{"id" => topic_id}} = conn

    if Repo.get(Topic, topic_id).user_id == conn.assigns.user.id do
      conn
    else
      conn
      |> put_flash(:error, "You cannot edit that")
      |> redirect(to: topic_path(conn, :index))
      |> halt()
    end
  end
end
