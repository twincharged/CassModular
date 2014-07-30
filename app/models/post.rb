require './app/models/concerns/model_logic'
require 'json'

class Post < ModelLogic
  include Cequel::Record

  before_create :set_created_at, :next_class_id
  before_save :serialize_tags

  key :id, :int
  column :user_id, :int, index: true
  column :body, :text
  column :public, :boolean
  column :serialized_taggees, :text
  column :created_at, :timestamp

##### Relations

  def user
  	User.find(self.user_id)
  end

  def likes
    self.class.relation.to_like_count(self.id)
  end

  def taggees
    User.find(JSON.parse(self.serialized_taggees))
  end

  private

  def serialize_tags
    return if self.serialized_taggees.nil?
    self.serialized_taggees.to_json
  end

end
