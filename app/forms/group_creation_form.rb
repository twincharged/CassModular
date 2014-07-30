require './app/forms/concerns/form_logic'

class GroupCreationForm < FormLogic

attribute :id, Integer
attribute :user_id, Integer
attribute :name, String
attribute :serialized_group_users, Array

  def self.create(attrs)
  	persist(attrs)
  end


  def self.persist(attrs)
	group = Group.create(attrs)
  end


end