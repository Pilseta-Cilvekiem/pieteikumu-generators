defmodule Mix.Tasks.Acmex.GenerateAccountKey do
  use Mix.Task

  @shortdoc "Generates acmex account key"

  def run(_) do
    account_path = Application.get_env(:acmex, :account_key_path)
    email = Application.get_env(:acmex, :account_email)
    domains = Application.get_env(:acmex, :domains)
    certificate_path = Application.get_env(:acmex, :certificate_path)

    :ok = account_path |> Path.dirname() |> File.mkdir_p()
    :ok = certificate_path |> Path.dirname() |> File.mkdir_p()

    cond do
      File.exists?(account_path) ->
        Mix.shell().info("Account key file already exists \"#{account_path}\"")

      true ->
        Mix.shell().info("Creating account key file in #{account_path}")

        case Acmex.OpenSSL.generate_key(:rsa, account_path) do
          {:ok, account_path} ->
            Mix.shell().info("Account key file successfully created at \"#{account_path}\"")

          {:error, reason} ->
            Mix.shell().error(
              "There was issue creating account key file at \"#{account_path}\":\n#{
                inspect(reason)
              }"
            )
        end
    end

    Application.ensure_all_started(:hackney)
    {:ok, _pid} = Acmex.start_link(account_path)

    {:ok, account} =
      case Acmex.get_account() do
        {:ok, account} = response ->
          Mix.shell().info("Found existing user for account key: \"#{account.contact}\"")
          response

        {:error, _} ->
          response = Acmex.new_account(["mailto:#{email}"], true)

          case response do
            {:ok, account} ->
              Mix.shell().info("Created new user for account key: \"#{account.contact}\"")

            {:error, reason} ->
              Mix.shell().error(
                "Couldn't create new user for account key: \"#{inspect(reason)}\""
              )
          end

          response
      end

    case Acmex.new_order(domains) |> IO.inspect() do
      {:ok, order} ->
        Mix.shell().info("Created order that expires at: \"#{order.expires}\"")

        challenge =
          order
          |> Map.get(:authorizations, [])
          |> List.first()
          |> Acmex.Resource.Authorization.http()

        Acmex.get_challenge_response(challenge) |> IO.inspect(label: :response)
        {:ok, challenge} = Acmex.validate_challenge(challenge) |> IO.inspect(label: :validate)
        Acmex.get_challenge(challenge.url) |> IO.inspect(label: :get_existing)

        Acmex.OpenSSL.generate_key(:rsa, certificate_path) |> IO.inspect(label: :generate_key)

        {:ok, csr} =
          Acmex.OpenSSL.generate_csr(certificate_path, domains)
          |> IO.inspect(label: :generate_csr)

        {:ok, order} = Acmex.finalize_order(order, csr) |> IO.inspect(label: :finalize_order)

      {:error, reason} ->
        Mix.shell().error("Couldn't create new order for domain: \"#{inspect(reason)}\"")
    end
  end
end
