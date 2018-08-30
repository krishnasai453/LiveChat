defmodule Messaging.UserView do
  use Messaging.Web, :view
  alias Messaging.User

  def first_name(%User{name: name}) do
  	name
  	|> String.split(" ")
  	|> Enum.at(0)
  end
end
