require File.dirname(__FILE__) + '/base'

describe Post do
	before do
		@post = Post.new
	end

	it "has a url containing only the slug: /my-post" do
		@post.created_at = '2008-10-22'
		@post.slug = "my-post"
		@post.url.should == '/my-post'
	end

	it "has a full url including the Blog.url_base" do
		@post.created_at = '2008-10-22'
		@post.slug = "my-post"
		Blog.stub!(:url_base).and_return('http://blog.example.com/')
		@post.full_url.should == 'http://blog.example.com/my-post'
	end

	it "produces html from the markdown body" do
		@post.body = "* Bullet"
		@post.body_html.should == "<ul>\n<li>Bullet</li>\n</ul>\n"
	end

	it "syntax highlights code blocks" do
		@post.to_html("```ruby\none\ntwo\n```").should == "<div class=\"highlight\"><pre><span class=\"n\">one</span>\n<span class=\"n\">two</span>\n</pre>\n</div>\n"
	end

	it "makes the tags into links to the tag search" do
		@post.tags = "one two"
		@post.linked_tags.should == '<a href="/tags/one">one</a> <a href="/tags/two">two</a>'
	end

	it "can save itself (primary key is set up)" do
		@post.title = 'hello'
		@post.body = 'world'
		@post.save
		Post.filter(:title => 'hello').first.body.should == 'world'
	end

	it "generates a slug from the title (but saved to db on first pass so that url never changes)" do
		Post.make_slug("RestClient 0.8").should == 'restclient-08'
		Post.make_slug("Rushmate, rush + TextMate").should == 'rushmate-rush-textmate'
		Post.make_slug("Object-Oriented File Manipulation").should == 'object-oriented-file-manipulation'
		Post.make_slug("Nifty preg_replace tricks").should == 'nifty-preg-replace-tricks'
	end
end
