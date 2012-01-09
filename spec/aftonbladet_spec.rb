describe Aftonbladet do
  use_vcr_cassette "requests"
  let(:aftonbladet) { Aftonbladet.new }
  
  it "should have some articles" do
    aftonbladet.should have(19).articles
  end
  
  describe "attributes" do
    let(:article) { aftonbladet.articles.first }
    
    it "should have a correct title" do
      article.title.should_not match(/^\d+. /)
    end
    
    it "should not have a blank title" do
      article.title.should_not be_empty
    end
    
    it "should have a #published_at attribute" do
      article.published_at.should be_instance_of(DateTime)
    end
    
    it "should have a #description" do
      article.description.should_not be_empty
    end
    
    it "should have a valid #image_url" do
      article.image_url.should match(%r{^http://mobil.aftonbladet.se})
    end
    
    it "should have an id" do
      article.id.should be_instance_of(Fixnum)
      article.id.should > 0
    end
  end
end