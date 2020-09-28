defmodule FriendsApp.DB.CSV do
  alias Mix.Shell.IO, as: Shell
  alias FriendsApp.CLI.Menu
  alias FriendsApp.CLI.Friend
  alias NimbleCSV.RFC4180, as: CSVParser

  def perform(chosen_menu_item) do
    case chosen_menu_item do
      %Menu{id: :create, label: _} -> create()
      %Menu{id: :read, label: _} -> read()
      %Menu{id: :update, label: _} -> Shell.info(">>>UPDATE<<<<")
      %Menu{id: :delete, label: _} -> Shell.info(">>>DELETE<<<<")
    end

    FriendsApp.CLI.Menu.Choice.start()
  end

  defp create do
    collect_data()
    |> transform_on_wrapped_list()
    |> prepare_list_to_save()
    |> save_csv_file([:append])
  end

  defp read do
    Application.fetch_env!(:csv_file, :path)
    |> File.read!()
    |> CSVParser.parse_string(skip_headers: true)
    |> Enum.map(fn [email, name, phone] ->
      %Friend{name: name, email: email, phone: phone}
    end)
    |> Scribe.console(data: [{"Name", :name}, {"Email", :email}, {"Phone", :phone}])
  end

  defp transform_on_wrapped_list(list) do
    list
    |> Map.from_struct()
    |> Map.values()
    |> wrap_in_list()
  end

  defp prepare_list_to_save(list) do
    list
    |> CSVParser.dump_to_iodata()
  end

  defp collect_data do
    Shell.cmd("clear")

    %Friend{
      name: prompt_message("Digite o nome: "),
      email: prompt_message("Digite o email: "),
      phone: prompt_message("Digite o telefone: ")
    }
  end

  defp prompt_message(message) do
    Shell.prompt(message)
    |> String.trim()
  end

  defp wrap_in_list(list) do
    [list]
  end

  defp save_csv_file(data, mode \\ []) do
    Application.fetch_env!(:csv_file, :path)
    |> File.write!(data, mode)
  end
end
