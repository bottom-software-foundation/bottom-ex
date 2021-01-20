# Bottom

[![Hex Version](http://img.shields.io/hexpm/v/bottom.svg)](https://hex.pm/packages/bottom)

This is an Elixir implementation of [bottom](https://github.com/kaylynn234/bottom).

Bottom encodes UTF-8 text into a sequence comprised of bottom emoji (`🫂✨🥺❤️`, with `,` sprinkled in for good measure) followed by `👉👈`. It can encode any valid UTF-8 — being a bottom transcends language, after all — and decode back into UTF-8.

## Installation

The package can be installed by adding `bottom` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:bottom, "~> 0.1.0"}
  ]
end
```

## Basic Usage

```elixir
iex> Bottom.encode("Hello world!")
{:ok, "💖✨✨,,👉👈💖💖,👉👈💖💖🥺,,,👉👈💖💖🥺,,,👉👈💖💖✨,👉👈✨✨✨,,👉👈💖💖✨🥺,,,,👉👈💖💖✨,👉👈💖💖✨,,,,👉👈💖💖🥺,,,👉👈💖💖👉👈✨✨✨,,,👉👈"}

iex> Bottom.decode("💖✨✨,,👉👈💖💖,👉👈💖💖🥺,,,👉👈💖💖🥺,,,👉👈💖💖✨,👉👈✨✨✨,,👉👈💖💖✨🥺,,,,👉👈💖💖✨,👉👈💖💖✨,,,,👉👈💖💖🥺,,,👉👈💖💖👉👈✨✨✨,,,👉👈")
{:ok, "Hello world!"}
```

## Documentation

Documentation can be found on [HexDocs](https://hexdocs.pm/bottom/index.html). See the docs for the [Bottom module](https://hexdocs.pm/bottom/Bottom.html) specifically.

## Other Libraries

* Reference implementation: https://github.com/kaylynn234/bottom
  * Python bindings: https://github.com/uYert/bottom-py
* Haskell implementation: https://github.com/LyricLy/bottom-hs
* C implementation: https://github.com/LyricLy/bottom-c
* Java implementation: https://github.com/SebbyLaw/bottom-java
* Web translator: https://kaylynn234.github.io/bottom-web
