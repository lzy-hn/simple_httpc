defmodule SimpleHttpc.MixProject do
  use Mix.Project

  def project do
    [
      app: :simple_httpc,
      version: "0.1.0",
      elixir: "~> 1.7",
      description: "a simple http client",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: [
        licenses: ["Public Domain"],
        links: %{"GitHub" => "https://github.com/hsieh/simple_httpc"}
      ]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :inets, :ssl]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false}
    ]
  end
end
