#!/usr/bin/env ruby

# forzen_string_literal: true

require 'date'

POSTS_DIR = '_posts'

post = ARGV[0]

File.open("#{POSTS_DIR}/#{Date.today.strftime('%Y-%m-%d-')}#{post}.md", "w") do |f|
    f.write(
        "---\ntitle: \n---"
    )
end

puts("[+] Created #{post} post")
