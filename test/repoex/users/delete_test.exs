defmodule Repoex.Users.DeleteTest do
  use Repoex.DataCase, async: true

  alias Repoex.{Error, User}
  alias Repoex.Users.{Create, Delete}

  describe "call/1" do
    setup do
      {:ok, %User{id: user_id}} = Create.call(%{"password" => "123456"})

      {:ok, user_id: user_id}
    end

    test "when the given user exists, delete the user", %{user_id: user_id} do
      response = Delete.call(user_id)

      assert {:ok, %User{id: _id}} = response
    end

    test "when the given user does not exists, returns an error" do
      response = Delete.call("e669e3db-e3c5-46c6-a985-ea7d76a50194")

      assert {:error, %Error{status: :not_found, result: "User not found"}} = response
    end
  end
end
