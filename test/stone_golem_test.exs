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
      StoneGolem.create(%{name: "Gomer", race: :gnome})
    end
  end

  test "can't create a StoneGolem without a race" do
    assert_raise ArgumentError, fn ->
      StoneGolem.create(%{name: "Fabian", class: :wizard})
    end
  end

  test "I can't enter level and exp properly" do
    assert_raise ArgumentError, fn ->
      StoneGolem.create(%{name: "Fabian", race: :human, class: :wizard, level: 13, experience: 45000})
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

  test "Find the atribute roll modifier" do
    golem = tanis_the_elf()
    assert StoneGolem.get_ability_mod(golem, :constitution) == -1
    assert StoneGolem.get_ability_mod(golem, :dexterity) == 1
    assert StoneGolem.get_ability_mod(golem, :strength) == 0
  end

  test "can create a StoneGolem with just a name" do
    golem = basic_edgar()
    assert golem.name == "Edgar Markov"
  end

  test "will default level to 1" do
    golem = basic_edgar()
    assert golem.level == 1
    assert golem.experience == 0
  end

  test "tanis the elf spent his exp" do
    golem = tanis_the_elf()
    assert golem.level == 2
    assert golem.experience == 1500
  end

  test "mork the ork has 3 levels?" do
    golem = mork_the_ork()
    assert golem.level == 3
    assert golem.experience == 3000
  end
  test "give edgar an id plz" do
    golem = basic_edgar()
    # firstname_lastname-race-class lowercase normalized
    assert golem.id == "edgar_markov-human-warrior"
  end

  test "IS there a range to tanis" do
    golem = tanis_the_elf()
    # firstname_lastname-race-class lowercase normalized
    assert golem.id == "tanis-elf-ranger"
  end

  test "ID Mork that ork" do
    golem = mork_the_ork()
    # firstname_lastname-race-class lowercase normalized
    assert golem.id == "mork-halforc-barbarian"
  end

  defp basic_edgar do
    {:ok, golem} = StoneGolem.create(%{name: "Edgar Markov", class: :warrior, race: :human})
    golem
  end

  defp tanis_the_elf do
    {:ok, golem} = StoneGolem.create(%{name: "Tanis", class: :ranger, race: :elf, experience: 1500})
    golem
  end

  defp mork_the_ork do
    {:ok, golem} = StoneGolem.create(%{name: "Mork", class: :barbarian, race: :halforc, level: 3})
    golem
  end
end
