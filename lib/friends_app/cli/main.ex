defmodule FriendsApp.CLI.Main do
  alias Mix.Shell.IO, as: Shell

  def start_app do
    Shell.cmd("clear")
    welcome_message
    Shell.prompt("Pressione enter para continuar...")
  end

  def welcome_message do
    Shell.info("=========== Friends App ===========")
    Shell.info("Seja bem-vindo à sua agenda pessoal")
    Shell.info("===================================")
  end
end