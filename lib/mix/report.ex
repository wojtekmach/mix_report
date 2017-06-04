defmodule Mix.Report do
  @moduledoc false

  def open_issue(repo_url, body) do
    url = String.replace(repo_url, ":body", URI.encode_www_form(body))
    Mix.Report.browser_open(url)
  end

	# From https://github.com/hexpm/hex/blob/v0.16.0/lib/mix/tasks/hex.docs.ex#L155
  def browser_open(path) do
    start_command = start_command()

    if System.find_executable(start_command) do
      System.cmd(start_command, [path])
    else
      Mix.raise "Command not found: #{start_command}"
    end
  end

  defp start_command() do
    case :os.type do
      {:win32, _} ->
        "start"
      {:unix, :darwin} ->
        "open"
      {:unix, _} ->
        "xdg-open"
    end
  end
end
