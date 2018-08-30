defmodule Messaging.UserController do
  use Messaging.Web, :controller
  alias Messaging.User
  alias Messaging.Auth

  plug :authenticate_user when action in [:index, :show]

  def index(conn, _params) do
  	users = Repo.all(Messaging.User)
    render conn, "index.html", users: users
  end

  def show(conn, %{"id" => id}) do
  	user = Repo.get(Messaging.User, id)
  	render conn, "show.html", user: user
  end

  def new(conn, _params) do
  	changeset = User.changeset(%User{}, %{})
  	render conn, "new.html", changeset: changeset
  end

 	def create(conn, %{"user" => user_params}) do
		changeset = User.registration_changeset(%User{}, user_params)
    case Repo.insert(changeset) do
    {:ok, user} ->
      conn
      |> put_flash(:info, "#{user.name} created!")
      |> redirect(to: user_path(conn, :index))
    {:error, changeset} ->
      render(conn, "new.html", changeset: changeset)
    end
  end

  def authenticate_user(conn, _opts) do
    if conn.assigns[:current_user] do
      conn
    else
      conn
      |> put_flash(:error, "You must be logged in to access that page")
      |> redirect(to: page_path(conn, :index))
      |> halt()
    end
  end

end
