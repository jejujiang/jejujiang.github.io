---
layout: post
title: English
description: Learn English
image: assets/images/pic11.jpg
nav-menu: true
---

{% for phrase in site.data.phrases %}
<p>{{ phrase.content | markdownify }}</p>
<p>{{ phrase.sentence | markdownify }}</p>
{% endfor %}
