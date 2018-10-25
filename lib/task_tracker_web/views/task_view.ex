defmodule TaskTrackerWeb.TaskView do
  use TaskTrackerWeb, :view

  def get_date_string(date) do
    NaiveDateTime.to_string(date)
  end
end
