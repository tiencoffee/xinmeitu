$countries = void
$institutions = void
$models = void
$tags = void
$albums = void

$clamp = (num, min, max) ->
	unless max?
		max = min
		min = 0
	if num < min => +min
	else if num > max => +max
	else +num

$random = (min, max) ->
	switch &length
	| 1
		max = min
		min = 0
	| 0
		max = 1
		min = 0
	Math.floor min + Math.random! * (max - min + 1)

$castArr = (arr) ->
	if Array.isArray arr => arr
	else if arr? => [arr]
	else []

$mark = (x, y, width, height) !->
	el = document.createElement \div
	el.className = "absolute bg-blue-500 pointer-events-none z-50"
	el.style <<<
		left: x + \px
		top: y + \px
		width: width + \px
		height: height + \px
	document.body.appendChild el
	await el.animate do
		opacity: 0
		300
	.finished
	el.remove!

#code

m.mount document.body, Preload

unless history.state
	history.pushState yes ""

addEventListener \touchstart (event) !->
	if el = event.target.closest \.tap
		rect = el.getBoundingClientRect!
		$mark rect.x, rect.y, rect.width, rect.height

addEventListener \contextmenu (event) !->
	event.preventDefault!
