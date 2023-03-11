defmodule RepoexWeb.UsersView do
  use RepoexWeb, :view

  alias Repoex.User

  def render("user.json", %{user: %User{} = user, token: token}), do: %{user: user, token: token}

  def render("sign_in.json", %{token: token}), do: %{token: token}
end
