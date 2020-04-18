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

alias Noospherical.Articles
alias Noospherical.Accounts

for category <- ~w(Random) do
  Articles.create_category!(category)
end
