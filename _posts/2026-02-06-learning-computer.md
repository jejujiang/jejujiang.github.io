---
title: Learning Computer 
---

<h1 class="highlight">{{ page.title }}</h1>

Do a find and replace to change all instances of "hello" to "Hello" in `hello.rb`.

`ruby -pi.bak -e 'gsub(/hello/, "Hello")' hello.rb`

- The `-p` option automatically reads and prints each line.
- The `i.bak` option modifies the file in-place and creates a backup named `hello.rb.bak`.
- The `-e` option executes the following code.

`File`

`File.absoulte_path`: If the given pathnam start with "`~`" it is NOT expaneded,
it is treated as a normal directory name.
