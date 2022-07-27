Info = m.comp do
	view: ->
		m \.h-full.flex.flex-col.justify-center.items-center.gap-3,
			m \.fa.fa-4x,
				class: m.class do
					"fa-#{@attrs.icon}": @attrs.icon
					"fa-spin": @attrs.spin
			m \.px-4,
				@attrs.text
			m \.w-1/3,
				@attrs.action
