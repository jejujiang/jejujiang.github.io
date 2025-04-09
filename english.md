---
layout: post
title: English
description: Learn English
image: assets/images/pic11.jpg
nav-menu: true
---

{% for phrase in site.data.phrases %}
<pre>{{ phrase.content }}</pre>
<pre>{{ phrase.sentence }}</pre>
{% endfor %}
