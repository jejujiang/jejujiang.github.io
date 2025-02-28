# frozen_string_literal: true

# !/usr/bin/env ruby

require 'date'

POST_DIR = '_posts'

post = ARGV[0]

File.open("#{POST_DIR}/#{Date.today.strftime('%Y-%m-%d-')}#{post}.md", 'w') do |f|
  f.write(
    "---\nlayout: post\ntitle: Title\ntags: [\"tag1\", \"tag2\"]\nexcerpt_separator: <!--more-->\n---\n\n"
  )
end

puts ("[+] Created #{post} post")

