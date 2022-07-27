require! {
	fs
	\glob-concat
	"jsdom": {JSDOM}
	"html-minifier-terser": {minify}
	"livescript2": livescript
	"../../npm/stylus2/stylus.min.js": stylus
}

paths = []
paths ++= globConcat.sync \comps/*
paths ++= globConcat.sync \pages/*
paths.push \index.ls
paths.push \index.styl

text = JSON.stringify paths
fs.writeFileSync \paths.json text

pwa = fs.readFileSync \pwa.json \utf8
pwa = JSON.parse pwa
# pwa.start_url = \.
pwa = JSON.stringify pwa
pwa = "data:application/manifest+json," + encodeURIComponent pwa

styl = fs.readFileSync \index.styl \utf8
styl = stylus.render styl, compress: yes

code = fs.readFileSync \index.ls \utf8
subcode = ""
for path in paths
	if path.endsWith \.ls
		subcode += fs.readFileSync path, \utf8
code .= replace \#code subcode
code = livescript.compile code

html = fs.readFileSync \dev.html \utf8
dom = new JSDOM html
doc = dom.window.document
doc.querySelectorAll '[dev]' .forEach (.remove!)
el = doc.getElementById \stylEl
el.textContent = styl
el.removeAttribute \id
el = doc.getElementById \codeEl
el.text = code
el.removeAttribute \id
el.removeAttribute \src
el.removeAttribute \type
el = doc.querySelector "link[rel=manifest]"
el.href = pwa

html = dom.serialize!
html = await minify html,
	collapseWhitespace: yes
	minifyCSS: yes
	minifyJS: yes
	removeAttributeQuotes: yes
	useShortDoctype: yes
fs.writeFileSync \index.html html

console.log "Built"
