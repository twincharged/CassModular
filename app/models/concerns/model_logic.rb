class ModelLogic

  def self.relation
    "#{self}Relation".constantize
  end

  def next_class_id
    self.id = "#{self.class}Relation".constantize.next_id
  end

  def set_created_at
  	self.created_at = Time.now
  end
end