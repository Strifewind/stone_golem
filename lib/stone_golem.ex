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
    golem = struct!(StoneGolem, data)
    {:ok, golem}
  end

  @enforce_keys [:name, :class, :race]

  defstruct [
    :name,
    :class,
    :race,
    level: 1,
    experience: 0,
    alignment: nil,
    diety: nil,
    age: nil,
    gender: nil,
    weight: nil,
    height: nil,
    eye_colour: nil,
    hair_colour: nil,
  ]

  @type class :: :warrior | :wizard | :rogue | :ranger | :sorcerer | :bard | :druid | :barbarian

  @type race :: :human | :elf | :dwarf | :halfling | :gnome | :halforc | :halfelf

  @type alignment :: :lawfulgood | :neutralgood | :chaoticgood | :lawfulneutral | :neutral | :chaoticneutral | :lawfulevil | :neutralevil | :chaoticevil

  @type t :: %__MODULE__{
    name: String.t(),
    class: class(),
    race: race(),
    level: pos_integer(),
    experience: non_neg_integer(),
    alignment: nil | alignment(),
    diety: nil | String.t(),
    age: nil | non_neg_integer(),
    gender: nil | String.t(),
    weight: nil | String.t(),
    height: nil | String.t(),
    eye_colour: nil | String.t(),
    hair_colour: nil | String.t(),
  }
  end
