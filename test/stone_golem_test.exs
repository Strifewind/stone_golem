defmodule StoneGolemTest do
  use ExUnit.Case
  doctest StoneGolem

  test "can't create a StoneGolem without a name" do
    assert {:error, "No name given"} = StoneGolem.create(%{})
  end
  
  test "can create a StoneGolem with just a name" do
    assert {:ok, golem} = StoneGolem.create(%{name: "Edgar Markov"})
    assert golem.name == "Edgar Markov"
  end
end
