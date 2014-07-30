require './app/models/concerns/model_logic'
require 'json'

class Group < ModelLogic
  include Cequel::Record

  before_create :set_created_at, :next_class_id
  before_save :serialize_group_users

  key :id, :int
  column :user_id, :int, index: true
  column :name, :text
  column :serialized_group_users, :text
  column :created_at, :timestamp

##### Relations

  def group_users
    User.find(JSON.parse(self.serialized_group_users))
  end


  private

  def serialize_group_users
    return if self.serialized_group_users.empty?
    self.serialized_group_users.to_json
  end


end
