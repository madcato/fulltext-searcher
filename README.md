# Fulltext Searcher

Project to investigate sqlite fulltext capabilities and RTree indexation.

## Documentation

- [SQLite FTS3 and FTS4 Extensions](https://www.sqlite.org/fts3.html)
- [The SQLite R*Tree Module](https://sqlite.org/rtree.html)
- [Nokigiri](https://nokogiri.org)

## Requiremnets

- Sqlite3 for Ruby: `gem install sqlite3`
- Nokigiri: `gem install nokogiri`

## Data

- [Wikipedia:Database download](https://en.wikipedia.org/wiki/Wikipedia:Database_download)
- [enwiki-latest-abstract.xml.gz](https://dumps.wikimedia.org/enwiki/latest/enwiki-latest-abstract.xml.gz)

## Parse XML in Ruby using Nokigiri

    require 'nokogiri'
    xml_str = <<EOF
        <THING1:things type="Container">
        <PART1:Id type="Property">1234</PART1:Id>
        <PART1:Name type="Property">The Name</PART1:Name>
        </THING1:things>
    EOF
    
    doc = Nokogiri::XML(xml_str)
    
    thing = doc.at_xpath('//things')
    puts "ID   = " + thing.at_xpath('//Id').content
    puts "Name = " + thing.at_xpath('//Name').content

## Sqlite3 Ruby

    require "sqlite3"
    
    # Open a database
    db = SQLite3::Database.new "test.db"
    
    # Create a table
    rows = db.execute <<-SQL
      create table numbers (
        name varchar(30),
        val int
      );
    SQL
    
    # Execute a few inserts
    {
      "one" => 1,
      "two" => 2,
    }.each do |pair|
      db.execute "insert into numbers values ( ?, ? )", pair
    end
    
    # Find a few rows
    db.execute( "select * from numbers" ) do |row|
      p row
    end
    
    # Create another table with multiple columns
    
    db.execute <<-SQL
      create table students (
        name varchar(50),
        email varchar(50),
        grade varchar(5),
        blog varchar(50)
      );
    SQL
    
    # Execute inserts with parameter markers
    db.execute("INSERT INTO students (name, email, grade, blog) 
                VALUES (?, ?, ?, ?)", ["Jane", "me@janedoe.com", "A", "http://blog.janedoe.com"])
                
    db.execute( "select * from students" ) do |row|
      p row
    end

### Do fulltext queries with sqlite3

    CREATE VIRTUAL TABLE enrondata1 USING fts3(content TEXT);     /* FTS3 table */

    SELECT count(*) FROM enrondata1 WHERE content MATCH 'linux';

Use `MATCH` instead `LIKE` to do full text queries.
