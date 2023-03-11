defmodule RepoexWeb.ReposControllerTest do
  use RepoexWeb.ConnCase, async: true
  import Mox

  alias Repoex.{Error, GetReposMock, Repository, User}
  alias Repoex.Users.Create
  alias RepoexWeb.Auth.Guardian

  describe "index/1" do
    setup %{conn: conn} do
      {:ok, %User{} = user} = Create.call(%{"password" => "123456"})

      {:ok, token, _claims} = Guardian.encode_and_sign(user)
      conn = put_req_header(conn, "authorization", "Bearer #{token}")

      {:ok, conn: conn}
    end

    test "when the user exists, return their repositories", %{conn: conn} do
      user = "RomuloHe4rt"

      body = [
        %Repository{
          id: 386_716_157,
          name: "25sites25days",
          html_url: "https://github.com/RomuloHe4rt/25sites25days",
          description: "Desenvolvendo um site por dia durante 25 dias",
          stargazers_count: 3
        },
        %Repository{
          id: 400_183_141,
          name: "api-quotation-php",
          html_url: "https://github.com/RomuloHe4rt/api-quotation-php",
          description: nil,
          stargazers_count: 0
        }
      ]

      expect(GetReposMock, :call, fn _repos -> {:ok, body} end)

      response =
        conn
        |> get(Routes.repos_path(conn, :index, user))
        |> json_response(:ok)

      assert %{
               "token" => _,
               "repos" => [
                 %{
                   "description" => "Desenvolvendo um site por dia durante 25 dias",
                   "html_url" => "https://github.com/RomuloHe4rt/25sites25days",
                   "id" => 386_716_157,
                   "name" => "25sites25days",
                   "stargazers_count" => 3
                 },
                 %{
                   "description" => nil,
                   "html_url" => "https://github.com/RomuloHe4rt/api-quotation-php",
                   "id" => 400_183_141,
                   "name" => "api-quotation-php",
                   "stargazers_count" => 0
                 }
               ]
             } = response
    end

    test "when the user does not exists, returns an error", %{conn: conn} do
      user = "no_existent_user_for_tests"

      body = %{
        message: "Not Found",
        documentation_url:
          "https://docs.github.com/rest/reference/repos#list-repositories-for-a-user"
      }

      expect(GetReposMock, :call, fn _repos -> {:error, Error.build(:not_found, body)} end)

      response =
        conn
        |> get(Routes.repos_path(conn, :index, user))
        |> json_response(:not_found)

      expected_response = %{
        "error" => %{
          "documentation_url" =>
            "https://docs.github.com/rest/reference/repos#list-repositories-for-a-user",
          "message" => "Not Found"
        }
      }

      assert response == expected_response
    end
  end
end
