defmodule Mix.Tasks.Start do
  use Mix.Task

  @shortdoc "Start [Friends App]"
  def run(_) do
    FriendsApp.init()
  end
end
