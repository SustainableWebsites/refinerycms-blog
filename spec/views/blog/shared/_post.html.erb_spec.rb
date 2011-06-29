require 'spec_helper'

describe "blog/shared/_post.html.erb" do
  let (:post) do
    stub_model(BlogPost).as_new_record
  end
  
  before do
    assign(:post, post)
  end
  
  it "should let users mark the blog post as a bookmark link" do
    render :partial => "blog/shared/post.html.erb", :locals => {:post => post}
    rendered.should contain("is a bookmark link?") # in the more options field
#   rendered.should contain checkbox for is_link boolean
#   rendered.should contain text field for link_url string
  end
end