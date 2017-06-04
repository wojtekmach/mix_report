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

    * Elixir & Erlang versions: Elixir #{System.version()}, OTP #{otp_version()}
    * Operating system: #{inspect :os.type()}, #{inspect :os.version()}

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

  # From https://github.com/fishcakez/dialyze/blob/6698ae582c77940ee10b4babe4adeff22f1b7779/lib/mix/tasks/dialyze.ex#L168
  def otp_version do
    major = :erlang.system_info(:otp_release) |> List.to_string
    vsn_file = Path.join([:code.root_dir(), "releases", major, "OTP_VERSION"])
    try do
      {:ok, contents} = File.read(vsn_file)
      String.split(contents, "\n", trim: true)
    else
      [full] ->
        full
      _ ->
        major
    catch
      :error, _ ->
        major
    end
  end
end
