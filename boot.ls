paths = await m.fetch \paths.json \json
texts = await Promise.all paths.map (path) ~>
	m.fetch path

styl = texts.pop!
styl = stylus.render styl, compress: yes
stylEl.textContent = styl

code = texts.pop!replace \#code texts.join \\n
livescript.run code

delete! livescript
delete! stylus
