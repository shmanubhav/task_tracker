# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     TaskTracker.Repo.insert!(%TaskTracker.SomeShema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias TaskTracker.Repo
alias TaskTracker.Users.User
alias TaskTracker.TaskMaps.TaskMap


Repo.insert!(%User{email: "mercury@localhost.com", name: "Mercury January"})
Repo.insert!(%User{email: "venus@localhost.com", name: "Venus February"})
Repo.insert!(%TaskMap{user_id: 2, task_id: 1})