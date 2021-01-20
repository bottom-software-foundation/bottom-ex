defmodule Bottom.MixProject do
  use Mix.Project

  @source_url "https://github.com/oliver-ni/bottom_ex"

  def project do
    [
      app: :bottom,
      version: "0.1.0",
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      description: description(),
      deps: deps(),
      package: package(),
      docs: docs(),
      source_url: @source_url
    ]
  end

  def application do
    [
      extra_applications: []
    ]
  end

  defp description do
    """
    Elixir library for translating between bottom and human-readable text.
    """
  end

  defp deps do
    [
      {:ex_doc, "~> 0.22", only: :dev, runtime: false}
    ]
  end

  defp package do
    [
      maintainers: ["Oliver Ni"],
      licenses: ["MIT"],
      links: %{"GitHub" => @source_url}
    ]
  end

  defp docs do
    [
      main: "readme",
      extras: ["README.md", "LICENSE"]
    ]
  end
end
