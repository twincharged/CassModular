class RelationLogic
    include Redis::Objects

  def self.next_id
    self.redis.incr("#{self.model.to_s.downcase}_next_id")
  end

  def key
    "#{self.class.model.to_s.downcase}:#{self.id}"
  end

  def self.model
  	model = "#{self}".match(/^(.+)Relation$/)
  	model[1].constantize
  end

end