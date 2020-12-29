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
db.execute( "select * from wiki_texts where abstract MATCHMATCH ?", ARGV[1] ) do |row|
  p row
end