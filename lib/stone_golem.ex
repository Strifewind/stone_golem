defmodule StoneGolem do
  @moduledoc """
  Documentation for StoneGolem main module.
  """

  @doc """
  StoneGolem character generator main struct. first pass is built to identify
  parts of a character sheet for a basic D & D Campaign. I would like to build


  defstruct [
    id: "Slug-of-name-player-level-class",
    name: "Edgar Markov",
    player: "Strifewind",
    class: :warrior,
    race: :human,
    alignment: :chaotic_neutral,
    diety: "",
    level: "1",
    size: :medium,

    age: 35,
    gender: "male",
    weight: "5'3",
    height: 125,
    eye_colour: "hazel",
    hair_colour: "black",

    strength: 25,
    dexterity: 18,
    constitution: 14,
    intelliegnce: 13,
    wisdom: 14,
    charisma: 16,

    health_points: 58,
    armour_class: 5,
    speed: 35,
    initiative: "+3",
    base_attack_bonus: "+6",

    fortitude: "+4",
    reflex: "+4",
    will: "+2",

    feat: [:name, "description"],
    skill: [:skill_name, "Calculated skill value?"]
  ]

  """

  def create(data) do
    golem = struct(StoneGolem.Golem, data)
    Map.put_new(golem, :name, name(data))
  end


  defp name(data) do
    Map.fetch(data, :name)
  end

  defmodule Golem do
    defstruct [
      name: nil
    ]
  end

end
