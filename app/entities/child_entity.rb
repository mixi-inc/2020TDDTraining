class ChildEntity
  attr_accessor :name, :birthday

  def initialize(id:, name:, :birthday)
    @id = id
    @name = name
    @birthday = birthday
  end
end
