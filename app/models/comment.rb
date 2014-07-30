# require './app/models/concerns/model_logic'

class Comment # < ModelLogic
  include Cequel::Record

  before_create :set_created_at, :next_class_id

  key :id, :int
  column :user_id, :int, index: true
  column :at_comment_id, :int
  column :body, :text
  column :created_at, :timestamp

##### Relations

  def user
  	User.find(self.user_id)
  end

  def likes
    self.class.relation.get_like_count(self.id)
  end

end
