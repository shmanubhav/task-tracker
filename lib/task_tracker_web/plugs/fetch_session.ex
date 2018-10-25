# Template used from http://www.ccs.neu.edu/home/ntuck/courses/2018/09/cs4550/notes/11-add-users/notes.html
defmodule TaskTrackerWeb.Plugs.FetchSession do
  import Plug.Conn

  def init(args), do: args

  def call(conn, _args) do
    user = TaskTracker.Users.get_user(get_session(conn, :user_id) || -1)
    if user do
      assign(conn, :current_user, user)
    else
      assign(conn, :current_user, nil)
    end
  end
end