# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Loany.Repo.insert!(%Loany.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

Loany.Repo.insert!(%Loany.Users.User{
  email: "admin@example.com",
  password_hash: Pow.Ecto.Schema.Password.pbkdf2_hash("admin")
})
