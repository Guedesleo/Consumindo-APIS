ExUnit.start()
Ecto.Adapters.SQL.Sandbox.mode(ReposFind.Repo, :manual)

Mox.defmock(ReposFind.Github.ClientMock, for: ReposFind.Github.Behaviour)
