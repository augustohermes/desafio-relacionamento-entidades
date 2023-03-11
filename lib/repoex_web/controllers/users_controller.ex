defmodule RepoexWeb.UsersController do
  use RepoexWeb, :controller

  alias Repoex.User
  alias RepoexWeb.{Auth.Guardian, FallbackController}

  action_fallback FallbackController

  def create(conn, params) do
    with {:ok, %User{} = user} <- Repoex.create_user(params),
         {:ok, token, _claims} <- Guardian.encode_and_sign(user) do
      conn
      |> put_status(:ok)
      |> render("user.json", user: user, token: token)
    end
  end

  def delete(conn, %{"id" => id}) do
    with {:ok, %User{}} <- Repoex.delete_user(id) do
      conn
      |> put_status(:no_content)
      |> text("")
    end
  end

  def sign_in(conn, params) do
    with {:ok, token} <- Guardian.authenticate(params) do
      conn
      |> put_status(:ok)
      |> render("sign_in.json", token: token)
    end
  end

  def update(conn, params) do
    with {:ok, %User{} = user} <- Repoex.update_user(params) do
      conn
      |> put_status(:ok)
      |> render("user.json", user: user, token: conn.private[:refreshed_token])
    end
  end
end
