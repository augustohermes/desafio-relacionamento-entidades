defmodule RepoexWeb.ReposController do
  use RepoexWeb, :controller

  alias Repoex.Repository
  alias RepoexWeb.FallbackController

  action_fallback FallbackController

  def index(conn, %{"user" => user}) do
    with {:ok, [%Repository{} | _] = repos} <- Repoex.get_repos(user) do
      conn
      |> put_status(:ok)
      |> render("repos.json", repos: repos, token: conn.private[:refreshed_token])
    end
  end
end
