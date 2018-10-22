defmodule StoneGolemTest do
  use ExUnit.Case
  doctest StoneGolem


  test "can't create a StoneGolem without a name" do
    assert_raise ArgumentError, fn ->
      StoneGolem.create(%{class: :warrior, race: :human})
    end
  end

  test "can't create a StoneGolem without a class" do
    assert_raise ArgumentError, fn ->
      StoneGolem.create(%{name: "Edgar Markov", race: :human})
    end
  end

  test "can't create a StoneGolem without a race" do
    assert_raise ArgumentError, fn ->
      StoneGolem.create(%{name: "Edgar Markov", class: :warrior})
    end
  end

  test "can create a StoneGolem with just a name" do
    golem = basic_edgar()
    assert golem.name == "Edgar Markov"
  end

  test "will default level to 1" do
    golem = basic_edgar()
    assert golem.level == 1
  end

  test "give edgar an id plz" do
    golem = basic_edgar()
    assert golem.id == "edgar_markov-human-warrior"  # firstname_lastname-race-class lowercase normalized
  end



  defp basic_edgar do
    {:ok, golem} = StoneGolem.create(%{name: "Edgar Markov", class: :warrior, race: :human})
    golem
  end

end
