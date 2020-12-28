# Fulltext Searcher

Project to investigate sqlite fulltext capabilities and RTree indexation.

## Documentation

- [SQLite FTS3 and FTS4 Extensions](https://www.sqlite.org/fts3.html)
- [The SQLite R*Tree Module](https://sqlite.org/rtree.html)
- [Nokigiri](https://nokogiri.org)

## Requiremnets

- Sqlite3
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

