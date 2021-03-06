defmodule Mix.Tasks.Utils.AddFakeFriends do
  use Mix.Task
  alias NimbleCSV.RFC4180, as: CSVParser
  alias FriendsApp.CLI.Friend

  @shortdoc "Add Fake Friends on App"
  def run(_) do
    Faker.start()

    create_friends([], 50)
    |> CSVParser.dump_to_iodata()
    |> save_csv_file()

    IO.puts("Amigos cadastrados com sucesso!")
  end

  defp create_friends(list, 1) do
    list ++ [random_list_friend()]
  end

  defp create_friends(list, count) do
    list ++ [random_list_friend()] ++ create_friends(list, count - 1)
  end

  defp random_list_friend do
    %Friend{
      name: Faker.Person.PtBr.name(),
      email: Faker.Internet.email(),
      phone: Faker.Phone.EnUs.phone()
    }
    |> Map.from_struct()
    |> Map.values()
  end

  defp save_csv_file(data) do
    Application.fetch_env!(:csv_file, :path)
    |> File.write!(data, [:append])
  end
end
