defmodule ReposFind.Factory do
  use ExMachina.Ecto, repo: ReposFind.Repo

  def repositories_factory do
    %{
      created_at: ~N[2016-12-20 16:25:28],
      description: nil,
      html_url: "https://github.com/abcdf123/jn",
      id: 76_972_604,
      language: nil,
      name: "jn",
      stargazers_count: 0
    }
  end
end
