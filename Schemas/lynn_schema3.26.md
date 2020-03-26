# Maja's Schema 
start = element songs {song}
song = element song {title, author*, verse}
title = element title {text}
author = element author {text}
year = element year {text}
verse = element verse {line}
line = element line {mixed...

Nationalism/colonization subcategories: 
- possession (land, people/bodies, labor, resources, justified expantion)
- national unity (brotherhood, solidarity, loyality, pride, patriotism)
- homeland (belonging, nostalgia)
- violence (action)

Positive/ Negative / ambigous associations applied to:
- land 
- people 
- home

type = attribute type {("belonging"|"possessive"|"aggressive"|"reverant"|"pious"|"nostalgic")}
group = attribute group {("women"|"hunters"|"cowards"|"enemies"|"children"|"settlers"|"warriors"|"tribe")}
mood = attribute mood {("positive"|"negative"|"ambiguous")}

