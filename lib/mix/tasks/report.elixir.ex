defmodule Mix.Tasks.Report.Elixir do
  use Mix.Task

  @shortdoc "Reports an Elixir issue"

  @moduledoc """
  Reports an Elixir issue.

  ## Command line options

    * `--print` - print the issue template instead of opening in the browser
  """

  @repo_url "https://github.com/elixir-lang/elixir/issues/new?body=:body"

  def run(args) do
    {opts, _, _} = OptionParser.parse(args)

    body = """
    ### Environment

    * Elixir & Erlang versions: Elixir #{System.version()}, OTP #{Mix.Report.otp_version()}
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
