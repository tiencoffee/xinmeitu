Tile = m.comp do
	view: ->
		m \.py-3.flex.flex-col.justify-center.items-center.flex-1.text-center,
			class: m.class do
				"disabled": @attrs.disabled
				"tap": @attrs.onclick
				@attrs.class
			ontouchstart: (event) !~>
				event.preventDefault! if event.cancelable
				@attrs.onclick? event
			if @attrs.icon
				m \.fa.fa-2x,
					class: "fa-#{@attrs.icon}"
			@children
