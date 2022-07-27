Tags = m.comp do
	itemView: (tag, page) ->
		m \.relative.aspect-2-3.text-center.opacity-0.tap,
			key: tag.id
			onclick: !~>
				m.route.set "/tag/#{tag.id}"
			m \img.w-full.h-full.object-cover,
				src: "https://cdn.jsdelivr.net/gh/tiencoffee/xinmeitu-poster/#{tag.thumb}.jpg"
				onload: (event) !~>
					{target} = event
					setTimeout !~>
						target.parentElement.classList
							..remove \opacity-0
							..add \anim--zoomIn
					, $random 200
			m \.absolute.bottom-0.w-full.text-sm.bg-gray-800.bg-opacity-75,
				tag.name

	view: ->
		m ListPage,
			obj: $tags
			page: @
