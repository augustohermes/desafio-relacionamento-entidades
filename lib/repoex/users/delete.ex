defmodule Repoex.Users.Delete do
  alias Repoex.{Error, Repo, User}

  def call(id) do
    case Repo.get(User, id) do
      nil -> {:error, Error.build(:not_found, "User not found")}
      user -> Repo.delete(user)
    end
  end
end
