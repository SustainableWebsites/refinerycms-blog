require 'spec_helper'

describe "blog/shared/_post.html.erb" do
  let (:post) do
    stub_model(BlogPost,
       :title => "Blog",
       :published_at => Time.now
       )
  end
  
  before do
    assign(:post, post)
    view.should_receive(:blog_post_teaser).and_return("Lorem ipsum")
  end
  
  it "should let users mark the blog post as a bookmark link" do
    
    render :partial => "blog/shared/post.html.erb", :locals => {:post => post}
    # in the more options field
    rendered.should contain("is a bookmark link?") 
  end
  
  it "should should contain checkbox for is_link boolean" do
    render :partial => "blog/shared/post.html.erb", :locals => {:post => post}
    rendered.should
  end
  
  it "should contain text field for link_url string" do
    render :partial => "blog/shared/post.html.erb", :locals => {:post => post}
    rendered.should
  end
  
end