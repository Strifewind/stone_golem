defmodule StoneGolem.Helper do
  def slugger(element) do
    Slug.slugify(element)
  end
end
