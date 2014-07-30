require './app/forms/concerns/form_logic'

class CommentCreationForm < FormLogic

attribute :id, Integer
attribute :user_id, Integer
attribute :body, String

 #  def self.create(attrs)
 #  	attrs[:id] = CommentRelation.next_id
 #  	persist(attrs)
 #  end


 #  def self.persist(attrs)
	# post = Comment.create(attrs)
	# CommentRelation.add_post(post)
 #  end


end