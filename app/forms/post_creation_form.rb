require './app/forms/concerns/form_logic'

class PostCreationForm < FormLogic

attribute :id, Integer
attribute :user_id, Integer
attribute :body, String
attribute :public, Boolean
attribute :serialized_taggees, Array

  def self.create(attrs)
  	persist(attrs)
  end


  def self.persist(attrs)
	post = Post.create(attrs)
	PostRelation.add_post(post)
  end


end