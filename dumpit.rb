#!/usr/bin/env ruby

require 'nokogiri'
require "sqlite3"

# Open a database
db = SQLite3::Database.new 'wikipedia.db'

# Create a table
rows = db.execute <<-SQL
  create virtual table if not exists wiki_texts using fts4(
    abstract text
  );
SQL

# Open xml file
doc = File.open('enwiki-latest-abstract.xml') do |f|
   Nokogiri::XML(f)
end

# Parse xml and dump it into db
doc.xpath('/feed/doc/abstract').each do |abstract|
  db.execute 'insert into wiki_texts values (?)', abstract.content
end

  