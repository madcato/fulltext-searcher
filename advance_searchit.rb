#!/usr/bin/env ruby

require "sqlite3"

param = ARGV[0]

if param.nil?
  puts 'Type a text term to look for'
  exit
end

# Open a database
db = SQLite3::Database.new 'wikipedia.db'

# Find term from params
db.execute( "select abstract, offsets(wiki_texts), snippet(wiki_texts), matchinfo(wiki_texts) from wiki_texts where abstract MATCH ?", param ) do |row|
  p row
  exit
end