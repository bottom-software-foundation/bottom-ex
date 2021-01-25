defmodule Bottom do
  @moduledoc """
  This is an Elixir implementation of [bottom](https://github.com/kaylynn234/bottom).

  Bottom encodes UTF-8 text into a sequence comprised of bottom emoji
  (`🫂✨🥺❤️`, with , sprinkled in for good measure) followed by `👉👈`.
  It can encode any valid UTF-8 - being a bottom transcends language,
  after all - and decode back into UTF-8.
  """

  @character_values [
    {200, "🫂"},
    {50, "💖"},
    {10, "✨"},
    {5, "🥺"},
    {1, ","},
    {0, "❤️"}
  ]

  @sep "👉👈"

  @doc ~S"""
  Encodes UTF-8 text into bottom emoji.

  ## Examples

      iex> Bottom.encode("Test")
      {:ok, "💖✨✨✨,,,,👉👈💖💖,👉👈💖💖✨🥺👉👈💖💖✨🥺,👉👈"}

      iex> Bottom.encode("Hello world!")
      {:ok, "💖✨✨,,👉👈💖💖,👉👈💖💖🥺,,,👉👈💖💖🥺,,,👉👈💖💖✨,👉👈✨✨✨,,👉👈💖💖✨🥺,,,,👉👈💖💖✨,👉👈💖💖✨,,,,👉👈💖💖🥺,,,👉👈💖💖👉👈✨✨✨,,,👉👈"}

      iex> Bottom.encode("がんばれ")
      {:ok, "🫂✨✨🥺,,👉👈💖💖✨✨🥺,,,,👉👈💖💖✨✨✨✨👉👈🫂✨✨🥺,,👉👈💖💖✨✨✨👉👈💖💖✨✨✨✨🥺,,👉👈🫂✨✨🥺,,👉👈💖💖✨✨🥺,,,,👉👈💖💖💖✨✨🥺,👉👈🫂✨✨🥺,,👉👈💖💖✨✨✨👉👈💖💖✨✨✨✨👉👈"}

  """
  def encode(text) do
    encoded =
      text
      |> :binary.bin_to_list()
      |> Enum.map(&encode_byte/1)
      |> Enum.map(&Enum.join/1)
      |> Enum.map(fn x -> x <> @sep end)
      |> Enum.join()

    {:ok, encoded}
  end

  @doc ~S"""
  Decodes a sequence of bottom emoji into UTF-8 text. Returns `{:error, :invalid}` if
  text is not a valid sequence of emojis.

  ## Examples

      iex> Bottom.decode("💖✨✨✨,,,,👉👈💖💖,👉👈💖💖✨🥺👉👈💖💖✨🥺,👉👈")
      {:ok, "Test"}

      iex> Bottom.decode("💖✨✨,,👉👈💖💖,👉👈💖💖🥺,,,👉👈💖💖🥺,,,👉👈💖💖✨,👉👈✨✨✨,,👉👈💖💖✨🥺,,,,👉👈💖💖✨,👉👈💖💖✨,,,,👉👈💖💖🥺,,,👉👈💖💖👉👈✨✨✨,,,👉👈")
      {:ok, "Hello world!"}

      iex> Bottom.decode("🫂✨✨🥺,,👉👈💖💖✨✨🥺,,,,👉👈💖💖✨✨✨✨👉👈🫂✨✨🥺,,👉👈💖💖✨✨✨👉👈💖💖✨✨✨✨🥺,,👉👈🫂✨✨🥺,,👉👈💖💖✨✨🥺,,,,👉👈💖💖💖✨✨🥺,👉👈🫂✨✨🥺,,👉👈💖💖✨✨✨👉👈💖💖✨✨✨✨👉👈")
      {:ok, "がんばれ"}

      iex> Bottom.decode("😀😃😄😁😆😅😂")
      {:error, :invalid}

  """
  def decode(text) do
    decoded =
      text
      |> String.trim_trailing(@sep)
      |> String.split(@sep)
      |> Enum.map(&decode_byte/1)
      |> :binary.list_to_bin()

    {:ok, decoded}
  rescue
    _ -> {:error, :invalid}
  end

  defp encode_byte(value) do
    case value do
      0 ->
        {_, emoji} = Enum.find(@character_values, fn {num, _} -> num == 0 end)
        [emoji]

      value ->
        _encode_byte(value)
    end
  end

  defp _encode_byte(value) do
    case value do
      0 ->
        []

      value ->
        {max, emoji} = Enum.find(@character_values, fn {num, _} -> value >= num end)
        [emoji | _encode_byte(value - max)]
    end
  end

  defp decode_byte(text) do
    text
    |> String.codepoints()
    |> Enum.map(&Enum.find(@character_values, fn {_, emoji} -> emoji == &1 end))
    |> Enum.map(fn {num, _} -> num end)
    |> Enum.sum()
  end
end
