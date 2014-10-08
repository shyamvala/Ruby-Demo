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
  
  mdContent = File.read(mdPath)
  erb :edit, :locals => { :filename => params[:filename], :content => mdContent }
end

post '/:filename/edit' do |filename|
  mdPath = "./#{filename}.md"
  fh = File.open(mdPath, 'w')
  fh.puts params[:content]
  fh.close
  
  redirect "/#{filename}.html"  
  
  
end
