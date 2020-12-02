defmodule ElixirWarTest do
  use ExUnit.Case
  doctest ElixirWar

  test "greets the world" do
    assert ElixirWar.hello() == :world
  end
end
