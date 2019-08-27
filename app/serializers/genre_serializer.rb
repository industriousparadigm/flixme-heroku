class GenreSerializer < ActiveModel::Serializer
  attributes :id, :name, :value, :label

  def value
    object.name
  end

  def label
    object.name.capitalize
  end
end
