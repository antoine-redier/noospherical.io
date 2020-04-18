# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Noospherical.Repo.insert!(%Noospherical.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Noospherical.{Repo, Articles}

comments = [
  %{
    body: "Elixir + Phoenix === 💜"
  },
  %{
    body: "JavaScript?!?!  What JavaScript..."
  }
]

case Repo.all(Articles.Comment) do
  [] ->
    comments
    |> Enum.each(fn comment ->
      Articles.create_comment(comment)
    end)

  _ ->
    IO.puts("Already have some comments")
end

alias Noospherical.Articles
alias Noospherical.Accounts

for category <- ~w(Random) do
  Articles.create_category!(category)
end
