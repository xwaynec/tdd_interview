require './boot'
require './topic'
require './post'
require './article'

describe "TDD example" do

  before do
    Topic.delete_all
    Post.delete_all
  end

  it "should validate title" do
    topic = Topic.new
    expect(topic.save).to eq(false)
  end

  it "should create topic from article" do
    article = Article.build( :title => "foobar" )
    article.save

    expect(Topic.last.title).to eq('foobar')
  end

  it "should create topic and post from article" do
    article = Article.build( :title => "foobar", :posts_attributes => [ { :content => "a" }, {:content => "b"} ] )

    expect(Topic.count).to eq(0)

    article.save

    topic = Topic.last
    expect(topic.title).to eq("foobar")
    expect(topic.posts.count).to eq(2)
    expect(topic.posts.last.content).to eq("b")
  end

  describe "existed article" do
    before do
      @topic = Topic.create!(:title => "foobar")
      @post = @topic.posts.create!( :content => "A" )
    end

    it "should find existed article" do
      @article = Article.find( @topic.id )

      expect(@article.class).to eq(Article)

      expect(@article.title).to eq("foobar")
    end

    it "should update topic" do
      @article = Article.find( @topic.id )

      @article.attributes = { :title => "foobar2" }
      @article.save

      @topic.reload
      expect(@topic.title).to eq("foobar2")
    end

    it "should update posts" do
      @article = Article.find( @topic.id )

      @article.attributes = { :posts_attributes => [ { :id => @post.id, :content => "Z" }, { :content => "X" } ] }
      @article.save

      @post.reload
      expect(@post.content).to eq("Z")

      expect(@topic.posts.count).to eq(2)
    end

  end

end
