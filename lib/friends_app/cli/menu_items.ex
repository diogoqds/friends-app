defmodule FriendsApp.CLI.MenuItems do
  alias FriendsApp.CLI.Menu

  def all, do: [
    %Menu{ label: "Cadastrar um amigo", id: :create },
    %Menu{ label: "Listar os amigos", id: :read },
    %Menu{ label: "Atualizar um amigo", id: :update },
    %Menu{ label: "Excluir um amigo", id: :delete },
  ]
end