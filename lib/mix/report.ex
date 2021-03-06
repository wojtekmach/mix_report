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

  def os_version do
    "#{inspect :os.type()}, #{inspect :os.version()}"
  end
end
