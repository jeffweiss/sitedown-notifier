defmodule StatusApp.Mixfile do
  use Mix.Project

  def project do
    [app: StatusApp,
     version: "0.0.1",
     elixir: "~> 1.0",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [ applications: [:logger, :inets, :httpoison, :ssl, :con_cache],
      registered: [:status_app],
      mod: {StatusApp,[]}
    ]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type `mix help deps` for more examples and options
  defp deps do
    [
      #{:con_cache, "~> 0.9"}
      {:floki, "~> 0.6.1"},
      {:httpoison, "~> 0.8.0"},
      {:con_cache, "~> 0.10.0"}
    ]
  end
end
