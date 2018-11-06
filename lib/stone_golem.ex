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


    seperate function for each attribute, store base state in struct.

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
    golem =
      struct!(StoneGolem, data)
      |> apply_id

    {:ok, golem}
  end

  @default_value 10

  @enforce_keys [:name, :class, :race]

  defstruct [
    :name,
    :class,
    :race,
    level: 1,
    experience: 0,
    id: nil,
    alignment: nil,
    diety: nil,
    age: nil,
    gender: nil,
    weight: nil,
    height: nil,
    eye_colour: nil,
    hair_colour: nil,
    strength: @default_value,
    dexterity: @default_value,
    constitution: @default_value,
    intelligence: @default_value,
    wisdom: @default_value,
    charisma: @default_value
  ]

  @type class :: :warrior | :wizard | :rogue | :ranger | :sorcerer | :bard | :druid | :barbarian

  @type race :: :human | :elf | :dwarf | :halfling | :gnome | :halforc | :halfelf

  @type alignment ::
          :lawfulgood
          | :neutralgood
          | :chaoticgood
          | :lawfulneutral
          | :neutral
          | :chaoticneutral
          | :lawfulevil
          | :neutralevil
          | :chaoticevil

  @type ability :: :strength | :dexterity | :constitution | :intelligence | :wisdom | :charisma

  @type t :: %__MODULE__{
          name: String.t(),
          class: class(),
          race: race(),
          level: pos_integer(),
          experience: non_neg_integer(),
          id: nil | String.t(),
          alignment: nil | alignment(),
          diety: nil | String.t(),
          age: nil | non_neg_integer(),
          gender: nil | String.t(),
          weight: nil | String.t(),
          height: nil | String.t(),
          eye_colour: nil | String.t(),
          hair_colour: nil | String.t(),
          strength: 0..30,
          dexterity: 0..30,
          constitution: 0..30,
          intelligence: 0..30,
          wisdom: 0..30,
          charisma: 0..30
        }

  @spec apply_id(golem :: t) :: t
  defp apply_id(golem) do
    %{golem | id: gen_id(golem)}
  end

  @spec gen_id(golem :: t) :: String.t()
  defp gen_id(golem) do
    nslug = Slug.slugify(golem.name, separator: "_")
    Enum.join([nslug, golem.race, golem.class], "-")
  end

  @spec get_ability_score(golem :: t, ability) :: nil | 0..30
  def get_ability_score(golem, ability) do
    case Map.get(golem, ability) do
      nil ->
        nil

      initial_value ->
        initial_value + racial_ability_adjustment(golem.race, ability)
    end
  end

  @spec racial_ability_adjustment(race, ability) :: integer
  def racial_ability_adjustment(:elf, :dexterity), do: 2
  def racial_ability_adjustment(:elf, :constitution), do: -2
  def racial_ability_adjustment(:dwarf, :constitution), do: 2
  def racial_ability_adjustment(:dwarf, :charisma), do: -2
  def racial_ability_adjustment(:gnome, :constitution), do: 2
  def racial_ability_adjustment(:gnome, :strength), do: -2
  def racial_ability_adjustment(:halfling, :dexterity), do: 2
  def racial_ability_adjustment(:halfling, :strength), do: -2
  def racial_ability_adjustment(:halforc, :strength), do: 2
  def racial_ability_adjustment(:halforc, :intelligence), do: -2
  def racial_ability_adjustment(:halforc, :charisma), do: -2
  def racial_ability_adjustment(_race, _ability), do: 0

  @spec get_ability_mod(golem :: t, ability) :: nil | -5..20
  def get_ability_mod(golem, ability) do
    case get_ability_score(golem, ability) do
      nil ->
        nil

      x when x in 0..1 ->
        -5

      x when x in 2..3 ->
        -4

      x when x in 4..5 ->
        -3

      x when x in 6..7 ->
        -2

      x when x in 8..9 ->
        -1

      x when x in 10..11 ->
        0

      x when x in 12..13 ->
        1

      x when x in 14..15 ->
        2

      x when x in 16..17 ->
        3

      x when x in 18..19 ->
        4

      x when x in 20..21 ->
        5

      x when x in 22..23 ->
        6
    end
  end
end
