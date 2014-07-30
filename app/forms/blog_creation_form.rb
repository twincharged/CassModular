require './app/forms/concerns/form_logic'

class BlogCreationForm < FormLogic

attribute :id, Integer
attribute :user_id, Integer
attribute :name, String
attribute :body, String
attribute :photo, String
attribute :youtube, String



  def self.create(attrs)
  	persist(attrs)
  end


  def self.persist(attrs)
	blog = Blog.create(attrs)
	BlogRelation.add_blog(blog)
  end


end