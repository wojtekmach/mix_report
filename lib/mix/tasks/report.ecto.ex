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

      [ecto_dep] = Mix.Dep.loaded_by_name([:ecto], [])
      {:ok, ecto_version} = ecto.status

      [adapter_dep] = Mix.Dep.loaded_by_name(@recognized_adapters, [])
      {:ok, adapter_version} = adapter_dep.status

      body = """
      ### Environment

      * Elixir & Erlang versions: Elixir #{System.version()}, OTP #{Mix.Report.otp_version()}
      * Database and version (PostgreSQL 9.4, MongoDB 3.2, etc.):
      * Ecto version: #{ecto_version}
      * Database adapter and version: #{adapter_dep.app} #{adapter_version}
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
  end
end
