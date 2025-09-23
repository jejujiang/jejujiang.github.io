#!/usr/bin/env ruby
# frozen_string_literal: true

require 'date'
require 'fileutils'

POSTS_DIR = '_posts'.freeze

def main
  if ARGV.empty?
    puts "Usage: #{$PROGRAM_NAME} <post_title> [--open]"
    exit(1)
  end

  post_title = ARGV[0]
  open_after_creation = ARGV[1] == '--open'

  #Create posts directory if it doesn't exist
  FileUtils.mkdir_p(POSTS_DIR)

  filename = "#{POSTS_DIR}/#{generate_filename(post_title)}.md"

  if File.exist?(filename)
    puts "[!] Error: File #{filename} already exists!"
    exit(1)
  end

  create_post_file(filename, post_title)
  puts "[+] Created post: #{filename}"

  if open_after_creation
    system("#{ENV['EDITOR'] || 'vi' } #{filename}")
  end
end

def generate_filename(title)
  sanitized_title =title.downcase.gsub(/[^a-z0-9\s]/, '').gsub(/\s+/, '-')
  "#{Date.today.iso8601}-#{sanitized_title}"
end

def create_post_file(filename, title)
  File.open(filename, 'w') do |f|
    f.write(<<~YAML
            ---
            title: #{title}
            ---

            ### 唐诗
            ### 成语
            ### The C Programming Language
            ### The Ruby Programming Language
            ### English
            YAML
           )
  end
end

main if __FILE__ == $PROGRAM_NAME
