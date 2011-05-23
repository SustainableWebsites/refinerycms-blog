require 'spec_helper'
require 'wordpress'

describe WordPress::Dump do
  let(:file_name) { File.realpath(File.join(File.dirname(__FILE__), '../../fixtures/wordpress_dump.xml')) }
  let(:dump) { WordPress::Dump.new(file_name) }

  it "should create a Dump object given a xml file" do
    dump.should be_a WordPress::Dump
  end

  it "should include a Nokogiri::XML object" do
    dump.doc.should be_a Nokogiri::XML::Document
  end

  describe "#tags" do
    let(:tags) do
      [ WordPress::Tag.new('css'), WordPress::Tag.new('html'),
        WordPress::Tag.new('php'), WordPress::Tag.new('ruby')]
    end

    it "should return all included tags" do
      tags.each do |tag|
        dump.tags.should include(tag)
      end
    end

    describe "#to_refinery" do
      let(:tag) { tags.last }
      let(:refinery_tag) { tag.to_refinery }

      it "should create a ActsAsTaggableOn::Tag" do
       refinery_tag.should be_a(ActsAsTaggableOn::Tag)
      end

      it "should copy the name attribute" do
        tag.name.should == refinery_tag.name
      end
    end
  end

  describe "#categories" do
    let(:categories) do
      [ WordPress::Category.new('Rant'), WordPress::Category.new('Tutorials'),
       WordPress::Category.new('Uncategorized') ]
    end

    it "should return all included categories" do
      categories.each do |cat|
        dump.categories.should include(cat)
      end
    end
  end

  describe "#pages" do
    it "should return all included pages" do
      dump.pages.should have(3).pages
    end

    context "the About me page" do
      let(:page) { dump.pages.last }

      it { page.title.should == 'About me' }
      it { page.content.should include('Lorem ipsum dolor sit') }
      it { page.creator.should == 'admin' }
      it { page.post_date.should == DateTime.new(2011, 5, 21, 12, 25, 42) }
      it { page.post_id.should == 10 }
      it { page.parent_id.should == 8 }

      it { page.should == dump.pages.last }
      it { page.should_not == dump.pages.first }
    end
  end

  describe "#authors" do
    it "should return all authors" do
      dump.authors.should have(1).author
    end

    context "the first author" do
      let(:author) { dump.authors.first }

      it { author.login.should == 'admin' }
      it { author.email.should == 'admin@example.com' }
    end
  end

  describe "#posts" do
    it "should return all posts" do
      dump.posts.should have(3).posts
    end

    context "the last post" do
      let(:post) { dump.posts.last }

      it { post.title.should == 'Third blog post' }
      it { post.content.should include('Lorem ipsum dolor sit') }
      it { post.creator.should == 'admin' }
      it { post.post_date.should == DateTime.new(2011, 5, 21, 12, 24, 45) }
      it { post.post_id.should == 6 }
      it { post.parent_id.should == 0 }
      it { post.status.should == 'publish' }

      it { post.should == dump.posts.last }
      it { post.should_not == dump.posts.first }
      
      describe "#categories" do
        it { post.categories.should have(1).category }
        it { post.categories.first.should == WordPress::Category.new('Rant') }
      end

      describe "#tags" do
        it { post.tags.should have(3).tags }

        it { post.tags.should include(WordPress::Tag.new('css')) }
        it { post.tags.should include(WordPress::Tag.new('html')) }
        it { post.tags.should include(WordPress::Tag.new('php')) }
      end

      it { post.tag_list.should == 'css,html,php' }

      describe "#comments" do
        it "should return all attached comments" do
          post.comments.should have(2).comments
        end

        context "the last comment" do
          let(:comment) { post.comments.last }
          
          it { comment.author.should == 'admin' }
          it { comment.email.should == 'admin@example.com' }
          it { comment.url.should == 'http://www.example.com/' }
          it { comment.date.should == DateTime.new(2011, 5, 21, 12, 26, 30) }
          it { comment.content.should include('Another one!') }
          it { comment.approved.should == true }

          it { comment.should == post.comments.last }
        end
      end
    end
  end
end
