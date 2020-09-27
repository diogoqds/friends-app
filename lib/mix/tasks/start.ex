defmodule Mix.Tasks.Start do
  use Mix.Task

  @shortdoc "Start [Friends App]"
  def run(_) do
    FriendsApp.CLI.Main.start_app
  end
end