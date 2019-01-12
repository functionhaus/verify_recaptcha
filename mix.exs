defmodule VerifyRecaptcha.MixProject do
  use Mix.Project

  def project do
    [
      app: :verify_recaptcha,
      name: "VerifyRecaptcha",
      version: "0.0.3",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      build_embedded: Mix.env() == :prod,
      deps: deps(),
      description: description(),
      package: package(),
      elixirc_paths: elixirc_paths(Mix.env),
      source_url: "https://github.com/functionhaus/verify_recaptcha",
      homepage_url: "https://functionhaus.com",

      docs: [
        main: "VerifyRecaptcha", # The main page in the docs
        logo: "assets/functionhaus_logo.png",
        extras: ["README.md"]
      ]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_),     do: ["lib"]

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
     {:plug, "~> 1.7"},
     {:recaptcha, "~> 2.3"},
     {:conn_artist, "~> 0.0"},
     {:meck, "~> 0.8", only: :test},
     {:ex_doc, "~> 0.19", only: :dev, runtime: false},
     {:dialyxir, "~> 0.5", only: [:dev], runtime: false}
    ]
  end

  defp description do
    "A Plug-compatible module for handling live Recaptcha responses."
  end

  defp package do
    [
     files: ["lib", "mix.exs", "README.md"],
     maintainers: ["FunctionHaus LLC, Mike Zazaian"],
     licenses: ["Apache 2"],

     links: %{"GitHub" => "https://github.com/functionhaus/verify_recaptcha",
              "Docs" => "https://hexdocs.pm/verify_recaptcha"}
     ]
  end
end
