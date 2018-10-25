defmodule TaskTrackerWeb.TaskView do
  use TaskTrackerWeb, :view

  def get_date_string(date) do
    if date == nil do
      "NIL"
    else
      "NOT NILL"
    end
  end
end
