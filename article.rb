# encoding: utf-8
class Article
  attr_accessor :topic
  attr_accessor :title
  attr_accessor :attributes

  def initialize(topic)
    @topic = topic 
  end

  def self.build(params = {})
    topic = Topic.new(params) 
  end

  def self.save
    topic.save 
  end

  def self.find(id)
    topic = Topic.find(id) 
    article = Article.new(topic)
    article.title = topic.title
    article
  end

  def save
    topic.attributes = attributes
    topic.save
  end

end