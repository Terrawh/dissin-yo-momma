require "sinatra"
require "haml"
require "kramdown"

file_contents = ""
f = File.open("disso.md", "r") 
f.each_line do |line|
  file_contents += line
end

file_contents

TEXT = file_contents


def sort_text(text)
  paragraphs = split_paragraphs(text)
  
  lines = []
  
  paragraphs.each do |paragraph|
    para = split_lines(paragraph)
    lines << para.join(" ")
  end
  
  lines
end

def split_paragraphs(text)
  text.split("\n\n");
end

def split_lines(paragraph)
  words = paragraph.split
  word_count = words.length
  
  sentence = []
  sentences = []
  
  (1..words.length.to_i).each do |n|
    sentence << words.shift
    
    if sentence.length == 7 || words.length == 0
      phrase = sentence.join(" ")
      phrase.gsub!(/['`]/,"")
      phrase.gsub!(".", "")
      phrase.gsub!(/[^\w\s]/, "")
      
      if sentence.include?("#")
        sentence = ["# [#{sentence.join(" ").gsub!("#", "")}](http://duckduckgo.com/?q=#{phrase}+!)"]
      else
        sentence = ["[#{sentence.join(" ")}](http://duckduckgo.com/?q=#{phrase}+!)"]
      end
      
      sentences << sentence
      sentence = []
    end
  end
  
  sentences
end


get "/" do
  @all_text = sort_text(TEXT)
  haml :index
end

__END__

@@ layout
%html
  %head
    %title Dissertation
  %body
    = yield

@@ index
- @all_text.each do |paragraph|
    = Kramdown::Document.new(paragraph).to_html