defmodule RepoexWeb.FallbackController do
  use RepoexWeb, :controller

  alias Repoex.Error
  alias RepoexWeb.ErrorView

  def call(conn, {:error, %Error{status: status, result: result}}) do
    conn
    |> put_status(status)
    |> put_view(ErrorView)
    |> render("error.json", result: result)
  end
end
