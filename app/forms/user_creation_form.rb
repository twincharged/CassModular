require './app/forms/concerns/form_logic'

class UserCreationForm < FormLogic

attribute :id, Integer
attribute :first_name, String
attribute :last_name, String


  def self.create(attrs)
  	persist(attrs)
  end


  def self.persist(attrs)
	User.create(attrs)
  end


end