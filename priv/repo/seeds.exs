# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     TaskTracker.Repo.insert!(%TaskTracker.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias TaskTracker.Repo
alias TaskTracker.Users.User
alias TaskTracker.Tasks.Task

Repo.insert!(%User{name: "John Doe", email: "john@abc.com"})
Repo.insert!(%User{name: "Dwight Schrute", email: "dwight@abc.com"})
Repo.insert!(%Task{title: "Wash clothes", description: "Finish laundry by saturday", user_id: 2})