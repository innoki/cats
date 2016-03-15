defmodule Cats.Mixfile do
  use Mix.Project

  def project do
    [app: :cats,
     version: "0.0.1",
     elixir: "~> 1.2",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  def application do
    [applications: [:logger, :trot]]
  end

  defp deps do
    [{:trot, github: "hexedpackets/trot"}]
  end
end
