defmodule Mix.Tasks.Report do
  use Mix.Task

  @shortdoc "Prints report help information"

  @moduledoc """
  Prints help information and available tasks.
  """

  def run(_) do
    help = """
    Available tasks:
    """

    Mix.shell.info help
    Mix.Task.run("help", ["--search", "report."])
  end
end
