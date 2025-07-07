require 'sinatra'
require 'erb'
require 'kramdown'

get '/' do
  @posts = Dir.glob("posts/*.md").sort.reverse.map do |post|
    {
      title: File.basename(post, ".md").gsub("-", " ").capitalize,
      date: File.mtime(post).strftime("%B %d, %Y"),
      content: Kramdown::Document.new(File.read(post)).to_html,
      url: "/#{File.basename(post, ".md")}"
    }
  end
  erb :index
end

get '/:post' do
  post_file = "posts/#{params[:post]}.md"
  if File.exist?(post_file)
    @post = {
      title: params[:post].gsub("-", " ").capitalize,
      date: File.mtime(post_file).strftime("%B %d, %Y"),
      content: Kramdown::Document.new(File.read(post_file)).to_html
    }
    erb :post
  else
    status 404
    "Post not found"
  end
end
