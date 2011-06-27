require 'spec_helper'

describe "blog/shared/_post.html.erb" do
  it "should let users select the blog post as a bookmark link" do
   render
   rendered.should contain("is a bookmark link?") # in the more options field
   rendered.should contain #checkbox
  end
end