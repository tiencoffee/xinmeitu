Swiper = m.comp do
	oninit: !->
		@touched = no
		@val = @attrs.value
		@oldVal = @attrs.value
		@max = @attrs.len - 1
		@changed = no

	ontouchstart: (event) !->
		@touched = yes
		@ontouchmove event

	ontouchmove: (event) !->
		y = event.touches.0.clientY - event.target.offsetTop
		height = event.target.offsetHeight
		@val = Math.floor $clamp y / height * @max, @max
		unless @val is @oldVal
			@changed = yes
			@attrs.oninput? @val
		@oldVal = @val

	ontouchend: (event) !->
		@touched = no
		if @changed
			@attrs.onchange? @val
			@changed = no

	view: ->
		m \.absolute.left-0.top-1/2.bottom-24.w-4.bg-gray-600.bg-opacity-75,
			class: m.class do
				"opacity-0": not @touched
			ontouchstart: @ontouchstart
			ontouchmove: @ontouchmove
			ontouchend: @ontouchend
			if @touched
				m \.absolute.left-16.py-2.px-3.whitespace-nowrap.bg-gray-800.bg-opacity-90.-translate-y-1/2.pointer-events-none.z-50,
					style:
						top: "#{@val / @max * 100}%"
					"#{@val + 1} / #{@attrs.len}"
