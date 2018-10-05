defmodule StoneGolemTest do
  use ExUnit.Case
  doctest StoneGolem

  test "greets the world" do
    assert StoneGolem.hello() == :world
  end
end
