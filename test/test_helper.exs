ExUnit.start()
Ecto.Adapters.SQL.Sandbox.mode(Repoex.Repo, :manual)

Mox.defmock(Repoex.GetReposMock, for: Repoex.GetReposBehaviour)
