defmodule DHT.Mixfile do
  use Mix.Project

  def project do
    [app: :dht,
     version: "0.0.1",
     elixir: "~> 1.2",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     compilers: [:make, :elixir, :app],
     aliases: aliases,
     deps: deps]
  end

  def application do
    [applications: [:logger],
     mod: {DHT, []}]
  end

  defp deps do
    []
  end

  defp aliases do
    [clean: ["clean", "clean.make"]]
  end
end

defmodule Mix.Tasks.Compile.Make do
  @shortdoc "Compiles DHT22 driver"

  def run(_) do
    {result, _error_code} = System.cmd("make", [], stderr_to_stdout: true)
    Mix.shell.info result
    :ok
  end
end

defmodule Mix.Tasks.Clean.Make do
  @shortdoc "Cleans DHT22 driver"

  def run(_) do
    {result, _error_code} = System.cmd("make", ["clean"], stderr_to_stdout: true)
    Mix.shell.info result
    :ok
  end
end
