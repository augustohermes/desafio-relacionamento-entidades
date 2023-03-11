defmodule RepoexWeb.ReposView do
  use RepoexWeb, :view

  alias Repoex.Repository

  def render("repos.json", %{repos: [%Repository{} | _] = repos, token: token}) do
    %{token: token, repos: repos}
  end
end
