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

  test "create's edgar with the default values" do
    golem = basic_edgar()
    assert golem.strength == 10
    assert golem.dexterity == 10
    assert golem.constitution == 10
    assert golem.intelligence == 10
    assert golem.wisdom == 10
    assert golem.charisma == 10
  end

  test "Racial ability modifiers will be applied on creation" do
    golem = tanis_the_elf()
    assert StoneGolem.get_ability_score(golem, :constitution) == 8
    assert StoneGolem.get_ability_score(golem, :dexterity) == 12
  end

  test "Will get nil for invalid ability" do
    golem = tanis_the_elf()
    assert StoneGolem.get_ability_score(golem, :ability_that_does_not_exist) == nil
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
    # firstname_lastname-race-class lowercase normalized
    assert golem.id == "edgar_markov-human-warrior"
  end

  defp basic_edgar do
    {:ok, golem} = StoneGolem.create(%{name: "Edgar Markov", class: :warrior, race: :human})
    golem
  end

  defp tanis_the_elf do
    {:ok, golem} = StoneGolem.create(%{name: "Tanis", class: :ranger, race: :elf})
    golem
  end
end
