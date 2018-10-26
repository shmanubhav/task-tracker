defmodule TaskTrackerWeb.LayoutView do
  use TaskTrackerWeb, :view

  def get_user_url(id) do
    "/users/#{id}"
  end
end
