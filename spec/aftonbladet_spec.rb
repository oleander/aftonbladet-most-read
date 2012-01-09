describe Aftonbladet do
  use_vcr_cassette "requests"
  let(:aftonbladet) { Aftonbladet.new }
  
  it "should have some articles" do
    aftonbladet.should have(19).articles
  end
end