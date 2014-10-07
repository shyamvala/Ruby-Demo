require 'rubygems'
require 'sinatra'
require 'fileutils'
require 'redcarpet'

#set :public_folder, File.dirname(__FILE__)

get '/' do
    redirect 'index.html'
end

get '/:path.html' do |path|
    content_type 'text/html', :charset => 'utf-8'

    mdPath = "./#{path}.md"
    mdContent = File.open(mdPath, 'r')
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, extensions = {})
    markdown.render(mdContent.read)
    
end