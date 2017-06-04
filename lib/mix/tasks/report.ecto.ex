if Code.ensure_loaded?(Ecto) do

  # TODO: move to Ecto

  defmodule Mix.Tasks.Report.Ecto do
    use Mix.Task

    @shortdoc "Reports an Ecto issue"

    @moduledoc """
    Reports an Ecto issue.

    ## Command line options

      * `--print` - print the issue template instead of opening in the browser
    """

    @repo_url "https://github.com/elixir-ecto/ecto/issues/new?body=:body"

    @recognized_adapters [:postgrex, :mariaex]

    def run(args) do
      {opts, _, _} = OptionParser.parse(args)

      body = """
      ### Environment

      * Elixir & Erlang versions: Elixir #{System.version()}, OTP #{Mix.Report.otp_version()}
      * Database and version: #{database_version()}
      * Ecto version: #{ecto_version()}
      * Database adapter and version: #{adapter_version()}
      * Operating system: #{Mix.Report.os_version()}

      ### Current behavior

      Include code samples, errors and stacktraces if appropriate.

      ### Expected behavior


      """

      if opts[:print] do
        Mix.shell.info body
      else
        Mix.Report.open_issue(@repo_url, body)
      end
    end

    defp ecto_version do
      # TODO: don't use private APIs!
      [ecto_dep] = Mix.Dep.loaded_by_name([:ecto], [])
      {:ok, ecto_version} = ecto_dep.status
      ecto_version
    end

    # TODO: instead grab adapter from application env and based on that grab the dep
    defp adapter_version do
      [adapter_dep] = Mix.Dep.loaded([]) |> Enum.filter(& &1.app in @recognized_adapters)
      {:ok, adapter_version} = adapter_dep.status

      "#{adapter_dep.app} #{adapter_version}"
    end

    # TODO: perhaps Repo would include a callback to grab this information?
    defp database_version do
      "PostgreSQL 9.4 / MongoDB 3.2 / etc"
    end
  end
end
