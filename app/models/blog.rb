require './app/models/concerns/model_logic'

class Blog < ModelLogic
  include Cequel::Record

  before_create :set_created_at, :next_class_id

  key :id, :int
  column :user_id, :int, index: true
  column :name, :text
  column :body, :text
  column :photo, :text
  column :youtube, :text
  column :created_at, :timestamp

##### Relations

  def user
  	User.find(self.user_id)
  end

  def added_users
    ids = BlogRelation.to_added_users(self.id)
    User.find(ids)
  end


  def likes
    BlogRelation.to_like_count(self.id)
  end

end
