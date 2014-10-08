#My first Ruby code
require 'sinatra'
require 'fileutils'
require 'redcarpet'

get '/' do
  redirect 'index.html'
end

get '/readme' do
  redirect 'README.html'
end

get '/:path.html' do |path|

  mdPath = "./#{path}.md"

  if File.exists?(mdPath) then

    content_type 'text/html', :charset => 'utf-8'

    mdContent = File.open(mdPath, 'r')
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, extensions = {})
    markdown.render(mdContent.read)


  else

    status 404
    "Not found"

  end
end

get '/:filename/edit' do |filename|
  mdPath = "./#{filename}.md"

  if not File.exists?(mdPath) then
    status 404
    return "Error: file #{filename}.md not found"
  end
  
  erb :edit, :locals => { :filename => params[:filename] }
end
