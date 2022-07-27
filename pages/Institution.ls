Institution = m.comp do
	oninit: !->
		@institution = $institutions.list[@attrs.key]
		@institution.list = $albums.list.filter (.institution is @institution)
		@institution.total = Math.ceil @institution.list.length / @institution.chunk

	onremove: !->
		@institution.list = void

	itemView: (item, page) ->
		m \img.w-full.aspect-2-3.object-cover.opacity-0.tap,
			key: item.id
			src: "https://cdn.jsdelivr.net/gh/tiencoffee/xinmeitu-poster/#{item.id}.jpg"
			onload: (event) !~>
				{target} = event
				setTimeout !~>
					target.classList
						..remove \opacity-0
						..add \anim--zoomIn
				, $random 200
			onclick: !~>
				m.route.set "/album/#{item.id}"

	view: ->
		m ListPage,
			obj: @institution
			page: @
