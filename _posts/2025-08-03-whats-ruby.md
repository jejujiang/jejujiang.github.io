---
title: What's Ruby?
---

<p class="lead"><a href="https://www.ruby-lang.org">Ruby</a> is a dynamic, open source programming language with a focus on simplicity and productivity. It has an elegant syntax that is natural to read and easy to write. </p>

Form [the project's readme:](https://github.com/ruby/ruby/blob/30a20bc166bc37acd7dcb3788686df149c7f428a/README.md#L4)
> Ruby is an interpreted object-oriented programming language often used for web development. It also offers many scripting features to process plain text and serialized files, or manage system tasks. It is simple, straightforward, and extensible.

It’s a programmer's best friend. Find out more by [visiting the project on GitHub](https://github.com/ruby/ruby).

---

```shell
# ubuntuSway
echo -e "input * { \n xkb_options caps:swapescape \n}" >> .config/sway/config

sed -i '$i\fish_vi_key_bindings' .config/fish/config.fish

sudo apt install build-essential zlib1g-dev libffi-dev libyaml-dev libreadline-dev

curl -fsSL https://rbenv.org/install.sh | bash

rbenv install <version>
```

---

![Large example image](http://placehold.it/800x400 "Large example image")
![Medium example image](http://placehold.it/400x200 "Medium example image")
![Small example image](http://placehold.it/200x200 "Small example image")

|-----------------+------------+-----------------+----------------|
| Default aligned |Left aligned| Center aligned  | Right aligned  |
|-----------------|:-----------|:---------------:|---------------:|
| First body part |Second cell | Third cell      | fourth cell    |
| Second line     |foo         | **strong**      | baz            |
| Third line      |quux        | baz             | bar            |
|-----------------+------------+-----------------+----------------|
| Second body     |[Liquid](http://shopify.github.io/liquid/)|[Jekyll](https://jekyllrb.com)                 |                |
| 2 line          |            |                 |                |
|=================+============+=================+================|
| Footer row      |            |                 |                |
|-----------------+------------+-----------------+----------------|

---

```ruby
# counts digits, white space, others
def main
  nwhite = 0
  nother = 0
  ndigit = Array.new(10, 0) # Initialize array with 10 zeros

  $stdin.each_char do |c|
    case c
    when '0'..'9'
      ndigit[c.to_i] += 1
    when ' ', '\n', '\t'
      nwhite += 1
    else
      nother += 1
    end
  end

  puts "digits = #{ndigit.join(' ')}, white space = #{nwhite}, other = #{nother}"
end

main
```

[TOP](#)
